<script lang="ts">
    import { GameType } from '@enums/gameTypes';
    import GAME_STATE from '@stores/GAME_STATE';
    import { type TKeyGameParam, type TLevelState } from '@typings/gameState';
    import { type TKeyCircleGameState } from '@typings/keyCircle';
    import { delay } from '@utils/misc';
    import { type Tweened, tweened } from 'svelte/motion';
    import { scale } from 'svelte/transition';
    import { GetRandomKeyFromSet, KEY_CIRCLE } from './config/gameConfig';
    import { Key } from '@enums/events';
    import { TempInteractListener } from '@utils/interactHandler';

    const UserRotation: Tweened<number> = tweened(0);

    let UserPressedKeys: { [key: string]: boolean } = {};

    const STROKE_WIDTH: number = 0.5;
    const RADIUS: number = 5;
    const DIAMETER: number = RADIUS * 2;
    const CIRCUMFERENCE: number = 2 * Math.PI * RADIUS;

    const SIZE_STYLES: string = `
        width: ${DIAMETER}vw;
        height: ${DIAMETER}vw;
    `;

    const SIZE_STYLES_QUARTER: string = `
        width: ${DIAMETER / 4}vw;
        height: ${DIAMETER / 4}vw;
    `;

    let Visible: boolean = false;

    let KeyCircleState: TKeyCircleGameState = null;

    let IterationState: TLevelState = null;

    let KeyListeners: {
        Down: ReturnType<typeof TempInteractListener>;
        Up: ReturnType<typeof TempInteractListener>;
    } = {
        Down: null,
        Up: null,
    };

    let CleanUpFunctions: Function[] = [];

    function clearCleanUpFunctions() {
        CleanUpFunctions.forEach(fn => fn());
        CleanUpFunctions = [];
    }

    //The code above shows the circle progress when the game is active and type is circle progress
    GAME_STATE.subscribe(state => {
        let shouldShow =
            state.active &&
            state.type === GameType.KeyCircle &&
            !KeyCircleState;
        if (shouldShow) {
            clearCleanUpFunctions();
            Visible = true;
            initialise();
        } else if (Visible && !shouldShow) {
            Visible = false;
            KeyCircleState = null;
            IterationState = null;
            clearKeyListeners();
            clearCleanUpFunctions();
        }
    });

    /** This code is responsible for clearing the key listeners.
     */
    function clearKeyListeners() {
        KeyListeners.Down?.removeListener();
        KeyListeners.Up?.removeListener();
        KeyListeners = {
            Down: null,
            Up: null,
        };

        UserPressedKeys = {};
    }

    /** This code is responsible for playing the iteration of the minigame.
     * This code should be called when the user presses the spacebar.
     * The code will return a promise that resolves to true if the user has
     * correctly input the key, and false otherwise.
     */
    async function playIteration() {
        if (!Visible) return;

        const duration = KeyCircleState.duration;

        const { currentStage, stages, keys } = KeyCircleState;
        const newValue = Math.floor((currentStage / stages) * 100);

        UserRotation.set(newValue, {
            duration,
        });

        return new Promise((resolve, _) => {
            let timeout = setTimeout(() => {
                resolve(false);
                return;
            }, duration);

            CleanUpFunctions.push(() => {
                if (timeout) clearTimeout(timeout);
                resolve(false);
            });

            clearKeyListeners();

            KeyListeners.Down = TempInteractListener(
                Key.down,
                (e: KeyboardEvent) => {
                    if (!Visible) return;

                    UserPressedKeys[e.key.toUpperCase()] = true;

                    if (IterationState) return;

                    const pressedKeys = Object.keys(UserPressedKeys);

                    if (pressedKeys.length === 2) {
                        clearTimeout(timeout);
                        clearKeyListeners();

                        const containsFirstKey = pressedKeys.includes(keys[0]);
                        const containsSecondKey = pressedKeys.includes(keys[1]);

                        UserRotation.set(newValue, {
                            duration: 0,
                        });

                        if (containsFirstKey && containsSecondKey) {
                            KeyCircleState.currentStage++;

                            if (
                                KeyCircleState.currentStage >
                                KeyCircleState.stages
                            ) {
                                resolve(true);
                                return;
                            } else {
                                GAME_STATE.playSound('primary');
                            }

                            KeyCircleState.keys = [
                                GetRandomKeyFromSet('PrimarySet'),
                                GetRandomKeyFromSet('SecondarySet'),
                            ];

                            resolve(playIteration());
                        } else {
                            resolve(false);
                            return;
                        }
                    }
                },
            );

            KeyListeners.Up = TempInteractListener(
                Key.up,
                (e: KeyboardEvent) => {
                    delete UserPressedKeys[e.key.toUpperCase()];
                },
            );
        });
    }

    /** This code is responsible for starting the game.
     * @param iterations The number of iterations to play.
     * @param difficulty The difficulty of the game.
     */
    async function startGame(iterations: number, config: TKeyGameParam) {
        if (!Visible) return;

        clearKeyListeners();

        UserRotation.set(0, {
            duration: 0,
        });

        let { difficulty, numberOfKeys } = config;
        difficulty =
            (difficulty || KEY_CIRCLE.FALLBACK_DIFFICULTY) >= 100
                ? 99
                : difficulty <= 0
                  ? 5
                  : difficulty;
        numberOfKeys = numberOfKeys || KEY_CIRCLE.FALLBACK_NUM_KEYS;

        KeyCircleState = {
            stages: numberOfKeys,
            currentStage: 1,
            duration: generateDuration(difficulty),
            keys: [
                GetRandomKeyFromSet('PrimarySet'),
                GetRandomKeyFromSet('SecondarySet'),
            ],
        };
        IterationState = null;

        await delay(500);

        if (!KeyCircleState) return;

        const success = await playIteration();

        if (!KeyCircleState) return;
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
                    KeyCircleState = null;
                    return;
                }
            } else {
                GAME_STATE.finish(false);
                KeyCircleState = null;
                return;
            }
        }, 500);

        CleanUpFunctions.push(() => {
            if (timeout) clearTimeout(timeout);
            IterationState = null;
        });
    }

    /** This code is responsible for generating a duration for a progress bar based on the difficulty.
     */
    function initialise() {
        if (!$GAME_STATE.active || KeyCircleState) return;

        const { iterations, config } = $GAME_STATE;
        startGame(iterations, config as TKeyGameParam);
    }

    /**
     * Generate a duration for a progress bar based on the difficulty
     * @param difficulty The difficulty should be between 0 and 100.
     */
    function generateDuration(difficulty): number {
        /** Set the minimum and maximum duration for a progress bar */
        const { MIN, MAX } = KEY_CIRCLE.DURATION;

        /** Calculate the duration based on the difficulty */
        let duration: number = MIN + (MAX - MIN) * ((100 - difficulty) / 100);

        /** Make the duration vary by 20% */
        const variation: number = duration * 0.2;
        const randomVariation: number = Math.random() * variation;
        duration += randomVariation;

        // Return the duration
        return duration;
    }
</script>

{#if Visible}
    <div
        transition:scale
        style={SIZE_STYLES}
        class="grid place-items-center primary-shadow default-game-position rounded-full w-fit h-fit"
    >
        {#if KeyCircleState}
            <div
                transition:scale
                class="flex flex-row items-center justify-center absolute"
            >
                {#each KeyCircleState?.keys as key}
                    <div
                        style={SIZE_STYLES_QUARTER}
                        class="grid place-items-center primary-shadow primary-bg"
                    >
                        <!-- {#key CircleState.target} -->
                        <p
                            transition:scale={{ duration: 100 }}
                            class="text-shadow absolute font-bold text-[2vw]"
                        >
                            {key}
                        </p>
                        <!-- {/key} -->
                    </div>
                {/each}
            </div>
        {/if}

        <svg
            style={SIZE_STYLES}
            version="1.1"
            class="z-0 absolute overflow-visible -rotate-90"
            xmlns="http://www.w3.org/2000/svg"
        >
            <circle
                style="stroke-width: {RADIUS * 0.1}vw"
                class="absolute fill-none primary-stroke"
                cx="50%"
                cy="50%"
                r="{RADIUS * 0.95}vw"
            />

            {#if KeyCircleState}
                {@const { stages } = KeyCircleState}
                <circle
                    style="transform: rotate({(1 / stages) * 360 - 90}deg);"
                    class=" absolute stroke-tertiary origin-center"
                    stroke-dasharray="{CIRCUMFERENCE}vw"
                    stroke-dashoffset="{CIRCUMFERENCE *
                        ((100 - $UserRotation) / 100)}vw"
                    stroke-width="{STROKE_WIDTH}vw"
                    fill-opacity="0"
                    cx="50%"
                    cy="50%"
                    r="{RADIUS * 0.95}vw"
                />
            {/if}
        </svg>
        {#if KeyCircleState}
            {@const { stages, currentStage } = KeyCircleState}
            {#each { length: stages } as _, i}
                <div
                    style="transform: rotate({((i + 1) / stages) * 360 -
                        90}deg);{SIZE_STYLES}"
                    class="  origin-center absolute"
                >
                    <div
                        class="absolute w-[0.5vw] h-[1vw] default-colour-transition -translate-y-1/4 center-x {IterationState ==
                        'fail'
                            ? 'bg-error glow-error'
                            : currentStage === i ||
                                (currentStage === stages && i === 0)
                              ? 'bg-accent glow-accent'
                              : (currentStage >= i && i !== 0) ||
                                  IterationState === 'success'
                                ? 'bg-success glow-success'
                                : 'bg-tertiary primary-shadow'} "
                    />
                </div>
            {/each}
        {/if}
    </div>
{/if}
