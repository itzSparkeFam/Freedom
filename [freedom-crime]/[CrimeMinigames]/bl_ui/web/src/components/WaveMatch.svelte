<script lang="ts">
    import { GameType } from '@enums/gameTypes';
    import HackWrapper from '@lib/HackWrapper.svelte';
    import GAME_STATE from '@stores/GAME_STATE';
    import type { THackGameParam, TLevelState } from '@typings/gameState';
    import { deepClone, delay, getRandomIntFromIntOrArray } from '@utils/misc';
    import { type Tweened, tweened } from 'svelte/motion';
    import Wave from './WaveMatch/Wave.svelte';
    import Slider from './micro/Slider.svelte';
    import type { TWaveMatchGameState, TWaveOptions } from '@typings/waveMatch';
    import { WAVE_MATCH } from './config/gameConfig';
    import { blur } from 'svelte/transition';

    const _BODY = getComputedStyle(document.body);
    const FOREGROUND_COLOUR: string = `rgba(${_BODY.getPropertyValue('--foreground').match(/\d+/g).join(',')}, 0.5)`;
    const ACCENT_COLOUR: string = `rgba(${_BODY.getPropertyValue('--accent').match(/\d+/g).join(',')}, 0.5)`;

    let Visible: boolean = false;

    let WaveMatchState: TWaveMatchGameState = null;

    let IterationState: TLevelState = null;

    const UserDuration: Tweened<number> = tweened(0);

    let Iterations: number = null;

    let containerRef: HTMLDivElement = null;

    let CleanUpFunctions: Function[] = [];

function clearCleanUpFunctions() {
    CleanUpFunctions.forEach(fn => fn());
    CleanUpFunctions = [];
}

    GAME_STATE.subscribe(state => {
        let shouldShow =
            state.active &&
            state.type === GameType.WaveMatch &&
            !IterationState;
        if (shouldShow) {
            clearCleanUpFunctions();
            Visible = true;
            initialise();
        } else if (Visible && !shouldShow) {
            Visible = false;
            WaveMatchState = null;
            IterationState = null;
            clearCleanUpFunctions();
        }
    });

    let SuccessChecker: Function = null;

    /** This code is responsible for playing the iteration of the minigame.
     * The code will return a promise that resolves to true if the user has
     * correctly input the key, and false otherwise.
     */
    async function playIteration() {
        if (!Visible) return;

        let timeout = setTimeout(() => {
            UserDuration.set(WaveMatchState.duration, {
                duration: WaveMatchState.duration,
            });
        }, 500);

        CleanUpFunctions.push(() => {
            if (timeout) clearTimeout(timeout);
        })
        return new Promise((resolve, _) => {
            let durationCheck = setTimeout(() => {
                finish(false);
            }, WaveMatchState.duration + 500);

            CleanUpFunctions.push(() => {
                if (durationCheck) clearTimeout(durationCheck);
                resolve(false);
            })
            SuccessChecker = () => {
                const overThreshold =
                    WaveMatchState.match >= WAVE_MATCH.MATCH_THRESHOLD;
                if (overThreshold) {
                    finish(true);
                }
            };

            function finish(bool: boolean) {
                const currentValue = $UserDuration;
                UserDuration.set(currentValue, {
                    duration: 0,
                });

                clearTimeout(durationCheck);
                resolve(bool);
            }
        });
    }

    /** This code is responsible for starting the game.
     * @param iterations The number of iterations to play.
     * @param difficulty The difficulty of the game.
     */
    async function startGame(iterations: number, config: THackGameParam) {
        if (!Visible) return;

        UserDuration.set(0, {
            duration: 0,
        });

        SuccessChecker = null;

        WaveMatchState = {
            duration: getRandomIntFromIntOrArray(config.duration),
            currentIteration: Iterations - iterations,
            userWave: deepClone(WAVE_MATCH.DEFAULT_WAVE),
            targetWave: generateTargetWave(),
            match: 0,
        };

        checkMatch();

        IterationState = null;

        await delay(500);

        if (!WaveMatchState) return
        const success = await playIteration();

        if (!WaveMatchState) return
        IterationState = success ? 'success' : 'fail';

        const isGameOver = success && iterations <= 1;
        if (success && isGameOver) {
            GAME_STATE.playSound('win');
        } else if (!isGameOver && success) {
            GAME_STATE.playSound('iteration');
        } else {
            GAME_STATE.playSound('lose');
        }


        let timeout = setTimeout(() => {
            if (!Visible) return;

            if (success && iterations > 0) {
                iterations--;
                if (iterations > 0) {
                    startGame(iterations, config);
                } else {
                    GAME_STATE.finish(true);
                    WaveMatchState = null;
                    return;
                }
            } else {
                GAME_STATE.finish(false);
                WaveMatchState = null;
                return;
            }
        }, 1000);

        CleanUpFunctions.push(() => {
            if (timeout) clearTimeout(timeout);
            IterationState = null;
        })
    }

    /** This code is responsible for generating a duration for a progress bar based on the difficulty.
     */
    function initialise() {
        if (!$GAME_STATE.active || WaveMatchState) return;

        const { iterations, config } = $GAME_STATE;
        Iterations = iterations;
        startGame(iterations, config as THackGameParam);
    }

    function generateTargetWave() {
        const { DEFAULT_WAVE, MIN_WAVE, MAX_WAVE, STEP_WAVE } = WAVE_MATCH;
        let targetWave = deepClone(DEFAULT_WAVE);

        for (const key in targetWave) {
            const randomValue = Math.random() * (MAX_WAVE[key] - MIN_WAVE[key]) + MIN_WAVE[key];

            // make sure the value fits with the step Config
            targetWave[key] = Math.round(randomValue / STEP_WAVE[key]) * STEP_WAVE[key];
        }

        return targetWave;
    }

    function checkMatch(): number {
        if (IterationState) return;
        if (!WaveMatchState?.userWave || !WaveMatchState?.targetWave) return 0;

        const userConfig = WaveMatchState.userWave;
        const waveConfig = WaveMatchState.targetWave;

        let totalMatch = 0;
        const keys = Object.keys(userConfig) as (keyof TWaveOptions)[];
        const totalKeys = keys.length;

        const { MIN_WAVE, MAX_WAVE } = WAVE_MATCH;

        keys.forEach(key => {
            const userValue = userConfig[key];
            const waveValue = waveConfig[key];
            const minValue = Number(MIN_WAVE[key]);
            const maxValue = Number(MAX_WAVE[key]);

            // Calculate how close the user's value is to the wave value within the range
            if (maxValue !== minValue) {
                const userNormalized =
                    (Number(userValue) - minValue) / (maxValue - minValue);
                const waveNormalized =
                    (Number(waveValue) - minValue) / (maxValue - minValue);

                const match = 1 - Math.abs(userNormalized - waveNormalized);
                totalMatch += match;
            }
        });

        // Calculate the percentage match
        WaveMatchState.match = Math.round((totalMatch / totalKeys) * 100);

        if (!SuccessChecker) return;
        SuccessChecker();
    }
</script>

{#if Visible}
    <HackWrapper
        state={IterationState}
        title={['Wave', 'Match']}
        subtitle="Change the parameters to match the wave."
        iterations={Iterations}
        iteration={WaveMatchState.currentIteration}
        progress={($UserDuration / WaveMatchState.duration) * 100}
    >
        <div class=" w-[80vh] h-[60vh] flex flex-col items-center gap-[5vh]">
            <div
                bind:this={containerRef}
                class="w-full h-[40vh] bg-secondary/90 border-[0.15vh] border-tertiary/50"
            >
                {#if containerRef && !IterationState}
                    {@const borderpx = window.innerHeight * 0.0015}
                    {@const height = containerRef.clientHeight - borderpx}
                    {@const width = containerRef.clientWidth - borderpx}
                    <div
                        transition:blur={{ delay: 500 }}
                        class="w-full h-full grid place-items-center"
                    >
                        <Wave
                            strokeStyle={FOREGROUND_COLOUR}
                            {...WaveMatchState.targetWave}
                            {height}
                            {width}
                        />
                        <Wave
                            strokeStyle={ACCENT_COLOUR}
                            {...WaveMatchState.userWave}
                            {height}
                            {width}
                        />
                    </div>
                {/if}
            </div>

            {#if WaveMatchState?.userWave}
                {@const maxConfig = WAVE_MATCH.MAX_WAVE}
                {@const minConfig = WAVE_MATCH.MIN_WAVE}
                {@const stepConfig = WAVE_MATCH.STEP_WAVE}
                {@const threshold = WAVE_MATCH.MATCH_THRESHOLD}
                <div
                    class="w-full h-[20vh] px-[5vh] flex flex-col items-center justify-center gap-[2vh]"
                >
                    <div
                        class="w-full h-[2vh] grid place-items-center primary-bg"
                    >
                        <div
                            class="h-full default-all-transition {IterationState ==
                            'success'
                                ? 'border-success glow-success bg-success/50'
                                : IterationState == 'fail'
                                  ? 'border-error glow-error bg-error/50'
                                  : 'bg-accent glow-accent'}"
                            style="width: {(WaveMatchState.match / threshold) *
                                100}%"
                        />
                        <div
                            class="h-full bg-success default-all-transition absolute"
                        />
                    </div>

                    <div
                        class="w-full h-full grid grid-cols-3 items-center justify-between gap-[0.5vh]"
                    >
                        <Slider
                            disabled={!!IterationState}
                            bind:value={WaveMatchState.userWave.speed}
                            min={minConfig.speed}
                            max={maxConfig.speed}
                            step={stepConfig.speed}
                            on:change={checkMatch}
                        />
                        <Slider
                            disabled={!!IterationState}
                            bind:value={WaveMatchState.userWave.amplitude}
                            min={minConfig.amplitude}
                            max={maxConfig.amplitude}
                            step={stepConfig.amplitude}
                            on:change={checkMatch}
                        />
                        <Slider
                            disabled={!!IterationState}
                            bind:value={WaveMatchState.userWave.wavelength}
                            min={minConfig.wavelength}
                            max={maxConfig.wavelength}
                            step={stepConfig.wavelength}
                            on:change={checkMatch}
                        />
                        <Slider
                            disabled={!!IterationState}
                            bind:value={WaveMatchState.userWave.segmentLength}
                            min={minConfig.segmentLength}
                            max={maxConfig.segmentLength}
                            step={stepConfig.segmentLength}
                            on:change={checkMatch}
                        />
                        <Slider
                            disabled={!!IterationState}
                            bind:value={WaveMatchState.userWave.lineWidth}
                            min={minConfig.lineWidth}
                            max={maxConfig.lineWidth}
                            step={stepConfig.lineWidth}
                            on:change={checkMatch}
                        />
                        <Slider
                            disabled={!!IterationState}
                            bind:value={WaveMatchState.userWave.timeModifier}
                            min={minConfig.timeModifier}
                            max={maxConfig.timeModifier}
                            step={stepConfig.timeModifier}
                            on:change={checkMatch}
                        />
                    </div>
                </div>
            {/if}
        </div>
    </HackWrapper>
{/if}
