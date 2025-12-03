import type { NavOperations, ShortcutOptions } from "@slidev/types";
import { defineShortcutsSetup } from "@slidev/types";

export default defineShortcutsSetup(
  (nav: NavOperations, base: ShortcutOptions[]) => {
    console.dir(base);
    return base.filter(
      (shortcut) =>
        shortcut.name !== "next_space" && shortcut.name !== "toggle_dark",
    );
  },
);
