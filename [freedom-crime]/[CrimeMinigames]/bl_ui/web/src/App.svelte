<script lang="ts">
    import { CONFIG, IS_BROWSER } from './stores/stores';
    import { InitialiseListen } from '@utils/listeners';
    import { Send } from '@enums/events';
    import { SendEvent } from '@utils/eventsHandlers';
    import Visibility from '@providers/Visibility.svelte';
    import Debug from '@providers/Debug.svelte';
    import CircleProgress from '@components/CircleProgress.svelte';
    import Progress from '@components/Progress.svelte';
    import KeyCircle from '@components/KeyCircle.svelte';
    import KeySpam from '@components/KeySpam.svelte';
    import NumberSlide from '@components/NumberSlide.svelte';
    import RapidLines from '@components/RapidLines.svelte';
    import CircleShake from '@components/CircleShake.svelte';
    import PathFind from '@components/PathFind.svelte';
    import Untangle from '@components/Untangle.svelte';
    import LightsOut from '@components/LightsOut.svelte';
    import DigitDazzle from '@components/DigitDazzle.svelte';
    import WordWiz from '@components/WordWiz.svelte';
    import CircleSum from '@components/CircleSum.svelte';
    import WaveMatch from '@components/WaveMatch.svelte';
    import MineSweeper from '@components/MineSweeper.svelte';
    import PrintLock from '@components/PrintLock.svelte';

    CONFIG.set({
        fallbackResourceName: 'debug',
        allowEscapeKey: true,
    });

    InitialiseListen();

    SendEvent(Send.uiLoaded);
</script>

<Visibility>
    <CircleProgress />
    <Progress />
    <KeyCircle />
    <KeySpam />
    <NumberSlide />
    <RapidLines />
    <CircleShake />

    <PathFind />
    <Untangle />
    <LightsOut />
    <DigitDazzle />
    <WordWiz />
    <CircleSum />
    <WaveMatch />
    <MineSweeper />
    <PrintLock />
</Visibility>

{#if $IS_BROWSER}
    <Debug />
{/if}
