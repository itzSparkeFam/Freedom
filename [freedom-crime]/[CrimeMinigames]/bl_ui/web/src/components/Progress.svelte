<script lang="ts">
    import GAME_STATE from '@stores/GAME_STATE';
    import { type TProgressGameState } from '@typings/progress';
    import { delay } from '@utils/misc';
    import { type Tweened, tweened } from 'svelte/motion';
    import { scale } from 'svelte/transition';
    import {
        GetRandomKeyFromSet,
        KEYS,
        PROGRESS
    } from './config/gameConfig';
    import { GameType } from '@enums/gameTypes';
    import { type TDifficultyParam, type TLevelState } from '@typings/gameState';
    import { Key } from '@enums/events';
    import { TempInteractListener } from '@utils/interactHandler';

    const UserSegmentSize: number = 0.5;
    const UserProgress: Tweened<number> = tweened(0);

    let Visible: boolean = false;

    let ProgressState: TProgressGameState = null;

    let IterationState: TLevelState = null;

    let KeyListener: ReturnType<typeof TempInteractListener>;

        let CleanUpFunctions: Function[] = [];

function clearCleanUpFunctions() {
    CleanUpFunctions.forEach(fn => fn());
    CleanUpFunctions = [];
}

    //The code above shows the circle progress when the game is active and type is circle progress
    GAME_STATE.subscribe(state => {
        let shouldShow =
            state.active && state.type === GameType.Progress && !ProgressState;
        if (shouldShow) {
            clearCleanUpFunctions();
            Visible = true;
            initialise();
        } else if (Visible && !shouldShow) {
            Visible = false;
            ProgressState = null;
            clearKeyListener();
            clearCleanUpFunctions();
        }
    });

    
    /** This code is responsible for clearing the key listeners.
     */
    function clearKeyListener() {
        KeyListener?.removeListener();
        KeyListener = null;
    }

    /** This code is responsible for playing the iteration of the minigame.
     * This code should be called when the user presses the spacebar.
     * The code will return a promise that resolves to true if the user has
     * correctly input the key, and false otherwise.
     */
    async function playIteration() {
        if (!Visible) return;

        const duration = ProgressState.duration;
        UserProgress.set(100, {
            duration,
        });

        return new Promise((resolve, _) => {
            let timeout = setTimeout(() => {
                resolve(false);
            }, duration); 

            CleanUpFunctions.push(() => {
                if (timeout) clearTimeout(timeout);
                resolve(false);
            })

            KeyListener = TempInteractListener(Key.pressed, (e: KeyboardEvent) => {
                const key = e.key.toUpperCase();

                if (!KEYS.Numbers.includes(key)) {
                    return;
                }

                clearTimeout(timeout);

                UserProgress.set($UserProgress, {
                    duration: 0,
                });

                if (key === ProgressState.key) {
                    const targetProg = ProgressState.target.progress;
                    const targetSize = ProgressState.target.size;

                    const userProg = $UserProgress;

                    if (
                        userProg > targetProg - UserSegmentSize &&
                        userProg < targetSize + targetProg
                    ) {
                        resolve(true);
                    } else {
                        resolve(false);
                        return;
                    }
                } else {
                    resolve(false);
                }
            });
        });
    }

    /** This code is responsible for starting the game.
     * @param iterations The number of iterations to play.
     * @param difficulty The difficulty of the game.
     */
    async function startGame(iterations: number, config: TDifficultyParam) {
        if (!Visible) return;

        clearKeyListener();

        UserProgress.set(0, {
            duration: 0,
        });

        let { difficulty } = config;
        difficulty = (difficulty || PROGRESS.FALLBACK_DIFFICULTY ) >= 100 ? 99 : difficulty <= 0 ? 5 : difficulty;

        ProgressState = {
            target: generateTarget(difficulty),
            duration: generateDuration(difficulty),
            key: GetRandomKeyFromSet('Numbers'),
        };

        await delay(500);

        if (!ProgressState) return
        const success = await playIteration();

        if (!ProgressState) return
        IterationState = success ? 'success' : 'fail';

        const isGameOver = success && iterations <= 1;
        if (success && isGameOver) {
            GAME_STATE.playSound('win');
        } else if (!isGameOver && success) {
            GAME_STATE.playSound('primary');
        } else {
            GAME_STATE.playSound('lose');
        }

        let timeout = setTimeout(() => {
            if (!Visible) return;

            IterationState = null;
            if (success && iterations > 0) {
                iterations--;
                if (iterations > 0) {
                    startGame(iterations, config);
                } else {
                    GAME_STATE.finish(true);
                    ProgressState = null;
                    return;
                }
            } else {
                GAME_STATE.finish(false);
                ProgressState = null;
                return;
            }
        }, 500);

        CleanUpFunctions.push(() => {
            if (timeout) clearTimeout(timeout);
            IterationState = null;
        })
    }

    /** This code is responsible for generating a duration for a progress bar based on the difficulty.
     */
    function initialise() {
        if (!$GAME_STATE.active || ProgressState) return;

        const { iterations, config } = $GAME_STATE;
        startGame(iterations, config as TDifficultyParam);
    }

    /**
     * Generate a duration for a progress bar based on the difficulty
     * @param difficulty The difficulty should be between 0 and 100.
     */
    function generateDuration(difficulty) {
        /** Set the minimum and maximum duration for a progress bar */
        const { MIN, MAX } = PROGRESS.DURATION;

        /** Calculate the duration based on the difficulty */
        let duration = MIN + (MAX - MIN) * ((100 - difficulty) / 100);

        /** Make the duration vary by 20% */
        const variation = duration * 0.2;
        const randomVariation = Math.random() * variation;
        duration += randomVariation;

        return duration;
    }

    /** Generate a target segment for the given difficulty.
     * The higher the difficulty, the harder the target will be to hit.
     * @param difficulty The difficulty should be between 0 and 100.
     */
    function generateTarget(difficulty) {
        // Make sure the difficulty is between 0 and 100.
        difficulty = difficulty >= 100 ? 99 : difficulty <= 0 ? 5 : difficulty;

        // Calculate the target size based on the difficulty.
        const { MAX } = PROGRESS.SIZE;
        const size = MAX - (difficulty / 100) * MAX;

        /**
         * The target should start atleastr 40% into the progress bar so the user has a chance to know.
         */
        const minProgress = 30;

        /**
         * The target should end before 100% - size so the whole target is visible.
         */
        const maxProgress = 100 - size;

        const progress =
            Math.random() * (maxProgress - minProgress) + minProgress;

        return {
            size,
            progress,
        };
    }
</script>

{#if Visible}
    <div
        transition:scale
        class=" primary-shadow default-game-position  w-[20vw] h-[0.5vw] primary-bg"
    >
        <div
            class="h-[2.5vw] aspect-square absolute grid place-items-center center-y primary-shadow primary-bg -translate-x-[130%]"
        >
                <p transition:scale={{duration: 100}}  class="text-shadow absolute font-bold text-[2vw]">
                    {ProgressState.key}
                </p>
        </div>

        <div
            style="left: {$UserProgress}%; width: {UserSegmentSize}vw"
            class="h-[1vw] center-y z-[10] absolute origin-center default-colour-transition {IterationState ===
            'success'
                ? 'glow-success bg-success'
                : IterationState === 'fail'
                ? 'glow-error bg-error'
                : 'bg-accent glow-accent'}"
        />

        {#if ProgressState}
            {@const { size, progress } = ProgressState.target}
            <div
                style="left: {progress}%; width: {size}%"
                class="h-[1vw] center-y absolute origin-center bg-tertiary z-0 target-segment"
            />
        {/if}
    </div>
{/if}

<style>
    .target-segment {
        filter: drop-shadow(0 0 0.1vw black);
        transition: all 0.1s ease-in-out;
    }
</style>
