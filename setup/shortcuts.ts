import type { NavOperations, ShortcutOptions } from '@slidev/types';
import { defineShortcutsSetup } from '@slidev/types';

/**
 * Filter out the default shortcuts that are disturbing the use of slidev-addon-tldraw
 * see:
 */
export default defineShortcutsSetup((nav: NavOperations, base: ShortcutOptions[]) =>
  base.filter((shortcut) => shortcut.name !== 'next_space' && shortcut.name !== 'toggle_dark')
);
