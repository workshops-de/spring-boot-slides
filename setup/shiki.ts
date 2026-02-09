import { rendererRich, transformerTwoslash } from '@shikijs/twoslash';
import type { ShikiSetupReturn } from '@slidev/types';
import { defineShikiSetup } from '@slidev/types';

export default defineShikiSetup((): ShikiSetupReturn => {
  return {
    themes: {
      dark: 'material-theme-ocean',
      light: 'light-plus',
    },
    transformers: [
      transformerTwoslash({
        explicitTrigger: true,
        renderer: rendererRich(),
      }),
    ],
  };
});
