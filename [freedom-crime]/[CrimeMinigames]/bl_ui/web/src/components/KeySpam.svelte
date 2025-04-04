<script lang="ts">
    import { Key, Receive } from '@enums/events';
    import { GameType } from '@enums/gameTypes';
    import GAME_STATE from '@stores/GAME_STATE';
    import { type TDifficultyParam, type TLevelState } from '@typings/gameState';
    import { type TKeySpamGameState } from '@typings/keySpam';
    import { type Tweened, tweened } from 'svelte/motion';
    import { scale } from 'svelte/transition';
    import { GetRandomKeyFromSet, KEYS, KEY_SPAM } from './config/gameConfig';
    import { delay } from '@utils/misc';
    import { TempInteractListener } from '@utils/interactHandler';

    const UserTimer: Tweened<number> = tweened(0);

    const STROKE_WIDTH: number = 0.5;
    const RADIUS: number = 4;
    const DIAMETER: number = RADIUS * 2;
    const CIRCUMFERENCE: number = 2 * Math.PI * RADIUS;

    const SIZE_STYLES: string = `
        width: ${DIAMETER}vw;
        height: ${DIAMETER}vw;
    `;

    let Visible: boolean = false;

    let KeySpamState: TKeySpamGameState = null;

    let IterationState: TLevelState = null;

    let KeyListener: ReturnType<typeof TempInteractListener>;
        let KeyUpListener: ReturnType<typeof TempInteractListener>;

            let CleanUpFunctions: Function[] = [];

function clearCleanUpFunctions() {
    CleanUpFunctions.forEach(fn => fn());
    CleanUpFunctions = [];
}

    //The code above shows the circle progress when the game is active and type is circle progress
    GAME_STATE.subscribe(state => {
        let shouldShow =
            state.active && state.type === GameType.KeySpam && !KeySpamState;
        if (shouldShow) {
            clearCleanUpFunctions();
            Visible = true;
            initialise();
        } else if (Visible && !shouldShow) {
            Visible = false;
            KeySpamState = null;
            IterationState = null;
            clearKeyListeners();
            clearCleanUpFunctions();
        }
    });

    /** This code is responsible for clearing the key listeners.
     */
    function clearKeyListeners() {
        KeyListener?.removeListener();
        KeyListener = null;
        KeyUpListener?.removeListener();
        KeyUpListener = null;
    }

    /** This code is responsible for playing the iteration of the minigame.
     * This code should be called when the user presses the spacebar.
     * The code will return a promise that resolves to true if the user has
     * correctly input the key, and false otherwise.
     */
    async function playIteration() {
        if (!Visible) return;

        const duration = KeySpamState.duration;
        UserTimer.set(100, {
            duration,
        });

        return new Promise((resolve, _) => {
            let interval = setInterval(() => {
                if (!Visible) return;
                
                KeySpamState.size -= 0.1;
                if (KeySpamState.size <= 0) {
                    KeySpamState.size = 0;
                }
            }, 1);

            let timeout = setTimeout(() => {
                if (!Visible) return;

                clearTimeout(timeout);
                clearInterval(interval);
                resolve(false);
            }, duration);


            CleanUpFunctions.push(() => {
                if (timeout) clearTimeout(timeout);
                if (interval) clearInterval(interval);
                resolve(false);
            })

            let isKeydown: boolean = false;

            KeyListener = TempInteractListener(
                Key.pressed,
                (e: KeyboardEvent) => {
                    if (!Visible) return;

                    if (isKeydown) return;
                    isKeydown = true;

                    const key = e.key.toUpperCase();

                    if (!KEYS.PrimarySet.includes(key)) {
                        return;
                    }

                    if (key === KeySpamState.key) {

                        GAME_STATE.playSound('primary');

                        let { size } = KeySpamState;

                        KeySpamState.size = size + 10;
                        if (KeySpamState.size >= 100) {
                            KeySpamState.size = 100


                            clearTimeout(timeout);
                            clearInterval(interval);

                            UserTimer.set($UserTimer, {
                                duration: 0,
                            });

                            resolve(true);  
                        }
                    }
                },
            );

            KeyUpListener = TempInteractListener(
                Key.up,
                (e: KeyboardEvent) => {
                    if (!Visible) return;

                    isKeydown = false;
                },
            );
        });
    }

    /** This code is responsible for starting the game.
     * @param iterations The number of iterations to play.
     * @param difficulty The difficulty of the game.
     */
    async function startGame(iterations: number, config: TDifficultyParam) {
        if (!Visible) return;

        clearKeyListeners();

        UserTimer.set(0, {
            duration: 0,
        });
        
        let { difficulty } = config;
        difficulty = (difficulty || KEY_SPAM.FALLBACK_DIFFICULTY) >= 100 ? 99 : difficulty <= 0 ? 5 : difficulty;

        KeySpamState = {
            duration: generateDuration(difficulty),
            key: GetRandomKeyFromSet('PrimarySet'),
            size: 0,
        };

        IterationState = null;

        await delay(500);

        if (!KeySpamState) return

        const success = await playIteration();

        clearKeyListeners();
        
        if (!KeySpamState) return
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
                    KeySpamState = null;
                    return;
                }
            } else {
                GAME_STATE.finish(false);
                KeySpamState = null;
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
        if (!$GAME_STATE.active || KeySpamState) return;

        const { iterations, config } = $GAME_STATE;
        startGame(iterations, config as TDifficultyParam);
    }

    /**
     * Generate a duration for a progress bar based on the difficulty
     * @param difficulty The difficulty should be between 0 and 100.
     */
    function generateDuration(difficulty: number): number {
        /** Set the minimum and maximum duration for a progress bar */
        const { MIN, MAX } = KEY_SPAM.DURATION;

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
        style={SIZE_STYLES}
        class="grid place-items-center primary-shadow default-game-position rounded-full"
    >
        <div class="absolute grid place-items-center z-10">
            {#if KeySpamState}
                    <p
                        transition:scale={{ duration: 100 }}
                        class="text-shadow absolute font-bold text-[2vw]  {!IterationState && 'animate-scale'}"
                    >
                        {KeySpamState.key}
                    </p>
            {/if}
        </div>

        <svg
            style={SIZE_STYLES}
            version="1.1"
            class=" absolute overflow-visible"
            xmlns="http://www.w3.org/2000/svg"
        >
            <circle
                style="stroke-width: {RADIUS * 0.1}vw z-0"
                class="absolute primary-fill"
                cx="50%"
                cy="50%"
                r="{RADIUS}vw"
            />

            {#if KeySpamState}
                {@const { size } = KeySpamState}
                <circle
                    class="absolute grid place-items-center default-colour-transition z-10 rounded-full {IterationState ===
                        'success'
                            ? 'glow-success fill-success'
                            : IterationState === 'fail'
                            ? 'glow-error fill-error'
                            : 'fill-accent glow-accent'}"
                    cx="50%"
                    cy="50%"
                    r="{size / 2}%"
                />
            {/if}

            <circle
                style="transform: rotate(-90deg);"
                class=" absolute radial stroke-tertiary origin-center target-segment primary-shadow"
                stroke-dasharray="{CIRCUMFERENCE}vw"
                stroke-dashoffset="{CIRCUMFERENCE *
                    (-(100 - $UserTimer) / 100)}vw"
                stroke-width="{STROKE_WIDTH}vw"
                fill-opacity="0"
                cx="50%"
                cy="50%"
                r="{RADIUS * 0.95}vw"
            />
        </svg>
    </div>
{/if}

<style>
    .animate-scale {
        animation: scale-in-out 0.5s infinite;
    }

    @keyframes scale-in-out {
    0% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.2);
    }
    100% {
        transform: scale(1);
    }
}
</style>