# Design System Specification: Editorial Verve

## 1. Overview & Creative North Star
This design system is built for the modern sanitary merchant—a professional who values precision, cleanliness, and structural integrity. Moving away from the generic utility of standard dashboards, our Creative North Star is **"The Botanical Architect."** 

We interpret the "sanitary shop" context not through sterile plastics, but through the lens of premium materials: polished stone, matte ceramics, and lush organic tones. The layout rejects the "flat box" template in favor of an editorial, high-end experience. By utilizing intentional asymmetry, deep forest greens, and tiered tonal layering, we transform a business tool into a sophisticated digital environment. 

The experience feels "custom-built" because it prioritizes negative space and monochromatic depth over traditional UI clutter.

---

## 2. Colors: Tonal Depth & The "No-Line" Rule
The palette is a sophisticated journey through emeralds and forest greens, anchored by soft, minty neutrals.

*   **Primary (`#005344`):** Our "Deep Forest." Used for high-level brand moments and core interaction states.
*   **Secondary (`#006a63`):** The "Emerald Accent." Used to draw attention to actionable data and success states.
*   **Surface Tiers:** We utilize `surface-container-lowest` (`#ffffff`) through `surface-container-highest` (`#e0e3e1`) to build architecture without lines.

### The "No-Line" Rule
**Explicit Instruction:** 1px solid borders are prohibited for sectioning or card definition. Boundaries must be defined solely through background color shifts. A `surface-container-lowest` card should sit on a `surface-container-low` background. This mimics the way light interacts with physical objects rather than drawing a cage around content.

### Glass & Gradient Soul
To ensure the UI doesn't feel "flat," we employ:
*   **Signature Textures:** Use a subtle linear gradient from `primary` (`#005344`) to `primary-container` (`#006d5b`) for primary CTAs or top-level navigation headers.
*   **Glassmorphism:** Floating action buttons or modal overlays must use a semi-transparent `surface` color with a `backdrop-blur` of 12px-20px. This allows the lush greens to bleed through, creating a sense of environmental continuity.

---

## 3. Typography: The Editorial Scale
We use a dual-typeface system to balance authority with readability.

*   **Display & Headlines (Manrope):** A geometric sans-serif that feels architectural and modern. Use `display-md` (2.75rem) for hero metrics and `headline-sm` (1.5rem) for section titles. The wide tracking and bold weights convey a "Premium Boutique" feel.
*   **Body & Labels (Inter):** The industry standard for legibility. We use `body-md` (0.875rem) for general content and `label-sm` (0.6875rem) for data tags. 

**Visual Hierarchy:** Establish dominance by pairing a large `display-sm` metric in `primary` with a tiny, uppercase `label-md` in `on-surface-variant`. The high contrast in scale creates a rhythmic, editorial flow.

---

## 4. Elevation & Depth: Tonal Layering
Traditional drop shadows are a secondary thought; layering is our primary tool.

*   **The Layering Principle:** 
    *   **Base:** `surface` (#f7faf8).
    *   **Sub-sections:** `surface-container-low` (#f1f4f2).
    *   **Interactive Cards:** `surface-container-lowest` (#ffffff).
*   **Ambient Shadows:** If an element must float (e.g., a critical notification), use a shadow with a 24px blur and 4% opacity. The shadow color must be a tint of `primary` (e.g., `#00201a`), never pure black.
*   **Ghost Borders:** If accessibility requires a border (e.g., in high-contrast modes), use `outline-variant` at 15% opacity. It should be felt, not seen.

---

## 5. Components: Refined Utility

### Buttons & Interaction
*   **Primary:** A gradient fill (`primary` to `primary-container`) with `roundness-md` (0.75rem). No border.
*   **Secondary:** `surface-container-high` background with `on-surface` text. This creates a "soft-touch" feel.
*   **Tertiary:** Transparent background, `primary` text, bold weight.

### Data Cards (The Core Pattern)
Based on the dashboard context, cards must not use dividers.
*   **Styling:** Background `surface-container-lowest`, `roundness-lg` (1rem).
*   **Content Separation:** Use `body-sm` vertical padding (1.5rem) to separate the "Header" from the "Value."
*   **Metric Indicators:** Instead of icons, use subtle vertical accent bars on the left side using the `secondary` or `tertiary` tokens.

### Input Fields
*   **States:** Background `surface-container-low`. On focus, transition the background to `surface-container-lowest` and add a "Ghost Border" of `primary` at 20% opacity.
*   **Shape:** `roundness-sm` (0.25rem) to maintain a professional, sharp-edged aesthetic for business inputs.

### Custom Component: The "Inventory Chip"
For sanitary shops (pipes, ceramics, etc.), use high-contrast status chips.
*   **Stocked:** `tertiary-container` background with `on-tertiary-container` text.
*   **Low Stock:** `error-container` background with `on-error-container` text.

---

## 6. Do's and Don'ts

### Do:
*   **DO** use whitespace as a functional tool. If two elements feel too close, increase the gap rather than adding a line.
*   **DO** use `manrope` for any number larger than 24px. The geometry of the typeface reinforces the "Architectural" theme.
*   **DO** nest `surface-container-highest` elements inside `surface-container-lowest` cards to create "wells" for secondary information.

### Don't:
*   **DON'T** use pure black (`#000000`) or pure grey. Every "neutral" in this system is slightly warmed with a green tint to maintain the brand soul.
*   **DON'T** use `roundness-full` for functional buttons; keep them `md` to reflect the sturdy nature of the hardware industry. Reserve `full` only for status chips and avatars.
*   **DON'T** stack more than three levels of depth. Surface -> Section -> Card is the limit to avoid a "muddy" interface.

---

**Director’s Final Note:** 
Remember, we are designing for a business owner who handles heavy, tactile products. The digital interface should reflect that same sense of weight and quality. Every pixel of "forest green" should feel like a conscious choice, not a default.