# 🧭 Expedition Assets

> **Gear up, venture into uncharted territory, and build the ultimate prehistoric outpost!**  
> An exploration & adventure asset mod for **Luanti** (formerly *Minetest*) by **ronrob-lu** (2026).  
> Released under the **MIT License** (with models based on CC0 Kenney assets).

---

## 🌟 Overview

Whether you're exploring lush prehistoric jungles, building a paleontological dig site, or hosting dinosaur-themed survival servers, **Expedition Assets** brings high-quality low-poly models, fully functional expedition gear, custom characters with accessories, and instant full-scale architectural structures.

### Key Highlights
- 📦 **Supply Drop Crates**: Interactive 1-block supply boxes with unboxing states and starter gear.
- ⛺ **Field Tents**: Realistic 5×4 multi-block wooden frames and weather-resistant canvas tents.
- ⛏️ **Tin Expeditioner Tools**: Specialized expedition-grade shovel, axe, pickaxe, rock hammer, and hoe—drop them on the ground as 3D display models!
- 🪧 **Writable Signposts**: Dual-arm and single-arm wooden direction posts with custom text and floating tags.
- 🧑‍🔬 **Three Iconic Characters**:
  1. **The Adventurer** (complete with custom 3D Safari Pith Helmet)
  2. **The Professor** (classic lab coat, glasses, and field badges)
  3. **The Researcher** (rugged lumberjack plaid, denim overalls, and expedition beard)
  - Apply them directly via player skin commands or encounter them as peaceful world NPCs!
- 🏛️ **Epic Architectural Landmarks**:
  - `/spawn_research_station`: 2-storey cobblestone & wood outpost with rooftop balcony and laboratory generator machinery.
  - `/spawn_park_entry`: Grand wooden archway with colossal 3D wooden block lettering (`PARQUE DE DINOSAURIOS` or any custom text!).
  - `/spawn_observation_tower`: Colossal 25-block tall structural steel high-hide observation tower with staging catwalk, safety ladder cage, full 360° glass cabin, hipped canopy roof, and comms spire beacon.

---

## 📋 Table of Contents
1. [Installation & Requirements](#-installation--compatibility)
2. [Section 1: Expedition Models & Gear](#-section-1-expedition-models--gear)
3. [Section 2: The Characters (Skins & NPCs)](#-section-2-the-characters)
4. [Section 3: Expedition Landmarks & Buildings](#-section-3-expedition-landmarks--buildings)
5. [Commands & Privileges](#-commands--privileges)
6. [Asset Pipeline (`dev/build_assets.py`)](#-asset-pipeline)
7. [⚠️ Known Issues & Unfinished / Planned Features](#-known-issues--unfinished--planned-features)
8. [License & Credits](#-license--credits)

---

## ⚙️ Installation & Compatibility

### Supported Engines
- **Luanti** (5.4+) / **Minetest** (5.4+)

### Compatible Game Families
- **Minetest Game (MTG)**: Native support (`default`, `wool`, `stairs`, `doors`, `farming`).
- **VoxeLibre / MineClone2 / Mineclonia**: Automatic fallback to MCL item definitions, materials, soundsets, and player models.

### Optional Dependencies
- `mobs_redo` or `mcl_mobs`: Enables living, walking, voice-lined NPCs and spawn eggs. (If absent, a smooth built-in fallback entity is used).
- `player_api` / `mcl_player`: Seamless player skin handling and hat attachment.

Simply clone or download this repository into your `mods/` directory:
```bash
cd ~/.minetest/mods/ # or your Luanti mods directory
git clone https://github.com/ronrob-lu/expedition-assets.git
```
Ensure `expedition_assets` is enabled in your world configuration.

---

## 🧰 Section 1: Expedition Models & Gear

All items use stylized low-poly `.obj` meshes calibrated to Luanti's 1-node coordinate grid.

### 1. Expedition Box (`box.obj` / `box-open.obj`)
- **Properties**: 1-node storage container. Non-craftable (special map/event reward).
- **Lid Mechanism**: Two distinct models swap dynamically on open/close without requiring skeletal rig animations.
- **Supply Drop Pack**: Every freshly placed Expedition Box comes pre-stocked with:
  - 🟡 **10x Yellow Wool** (`wool:yellow` or `mcl_wool:yellow`)
  - 🪵 **20x Wood Planks** (`default:wood` or `mcl_core:wood`)
  - 🛠️ **2x of each Tin Tool** (Shovel, Axe, Pickaxe, Rock Hammer, Hoe)
  - 🪧 **4x of each Signpost** (Double & Single)
- **Protection**: Digging only allowed once emptied; explosion-proof storage.

---

### 2. Expedition Tents (`tent.obj` / `tent-canvas.obj`)
Large shelters spanning **5 blocks wide × 4 blocks deep × ~3.4 blocks tall**. Players can walk right inside!

#### 🔹 Tent Frame (`tent.obj`)
A structural timber A-frame made from 7 sticks in an inverted "U" shape:
```
[Stick] [Stick] [Stick]
[Stick] [     ] [Stick]
[Stick] [     ] [Stick]
```

#### 🔹 Expedition Tent with Canvas (`tent-canvas.obj`)
Weatherproof yellow canopy fitted over the wooden frame.
- **Crafting Recipe (Shapeless)**:
  `1x Tent Frame` + `3x Yellow Wool`

---

### 3. Tin Expedition Tools (`tool-*.obj`)
Forged using **Tin Ingot** (`default:tin_ingot`, or copper/iron in MCL) and wooden sticks:

| Tool | Recipe Shape | Description & Feature |
| :--- | :--- | :--- |
| **Tin Shovel** | Standard Shovel | Speedy digging through dirt, sand, and gravel. |
| **Tin Axe** | Standard Axe | Efficient timber-cutting and brush clearing. |
| **Tin Pickaxe** | Standard Pickaxe | Durable mining tool for stone and fossil excavation. |
| **Tin Rock Hammer** | Top row: 3x Tin<br>Middle: 1x Stick | **Specialty Tool**: One stick shorter than a pickaxe! Faster attack and softer stone cracking. Perfect for paleontology field work. |
| **Tin Hoe** | Standard Hoe | Prepares field crops and expedition gardens. |

> 💡 **3D Display on the Ground**: Sneak + Right-Click (`Shift + Right Click`) any flat surface to place your tool on the ground as a decorative 3D model! Punch/dig the model to retrieve the tool with its durability wear intact.

---

### 4. Writable Signposts (`signpost.obj` / `signpost-single.obj`)
- **`signpost.obj`**: Two-directional pointing arrows. Crafted with:
  ```
  [Plank] [Stick] [Plank]
  [     ] [Stick] [     ]
  [     ] [Stick] [     ]
  ```
- **`signpost-single.obj`**: Single directional arrow. Crafted with:
  ```
  [Stick] [Plank]
  [Stick] [     ]
  [Stick] [     ]
  ```
- **Interactive Writing**: Right-click to type messages (up to 120 characters). Messages appear in node infotext and hover as high-visibility floating nametags.

---

## 👥 Section 2: The Characters

Experience the expedition with three distinct roles modeled after the expedition lore:

| Character | Appearance Details | In-Game Persona |
| :--- | :--- | :--- |
| **1. The Adventurer** | Khaki safari suit, ammo/utility vest, cargo pants, utility belt, and custom **3D Safari Pith Hat** | Fearless jungle tracker and cartographer. |
| **2. The Professor** | White lab coat, glasses/spectacles, blue collared shirt, and field ID badge | Fossil specialist, theorist, and senior expedition director. |
| **3. The Researcher** | Red-and-black lumberjack plaid shirt, rugged denim overalls, and full grey beard | Veteran navigator, compass master, and survivalist. |

### 🎩 The 3D Safari Hat (`expedition_assets_hat.obj`)
The Adventurer features an exclusive 3D mesh Safari Hat attached directly to the character’s head bone. It swivels and animates with player and mob head movements.

### 🎮 Skin Switching Command
Players can equip any expedition outfit instantly:
```bash
/ea_apply_skin <adventurer | professor | researcher | default> [player]
```
*(Requires `ea_builder` privilege when changing another player's skin).*

### 🚶 Peaceful Mobs / NPCs
- **Mobs Redo / mcl_mobs Support**: Spawnable via spawn eggs (`Egg: Adventurer`, etc.) or commands. They walk around, avoid monsters, and converse when right-clicked.
- **Standalone Fallback**: Even without third-party mob engines installed, the mod includes a built-in interactive NPC entity that looks toward players and speaks field dialogue!
- **Spawn Command**:
  ```bash
  /ea_spawn_npc <adventurer | professor | researcher | all>
  ```

---

## 🏛️ Section 3: Expedition Landmarks & Buildings

Spawn full architectural builds aligned to your look direction:

### 🔬 1. Research Station (`/spawn_research_station`)
Based on `research_station.jpg` and `research-station-structure.jpg`:
- **Dimensions**: 9×9 main outpost + 4×5 annex wing (2 floors).
- **Architecture**: Heavy cobblestone ground floor, dark stone-brick reinforcement columns, warm wooden upper floor, glass observation windows, and flat perimeter slab roofing.
- **Details**:
  - Exterior machinery bank (generators, furnace batteries, and steel components).
  - Rooftop observation balcony with perimeter fencing.
  - Interior library, ladder well, illumination torches, and an active **Expedition Supply Box**.
  - Front entrance path with a dedicated station direction signpost.
  - Automatically stations the Professor, Researcher, and Adventurer on site!

### 🦕 2. Dino Park Entry (`/spawn_park_entry [LINE 1|LINE 2]`)
Based on `entry-and-three-characters.png` and `park-entry.jpg`:
- **Dimensions**: 17 blocks wide, 16 blocks tall, 11-block wide clearance passage.
- **Architecture**: Massive 3×3 dark jungle log pillars set upon stepped wooden bases, decorative stair bracing, wall torches, and open gate leaves swung inward.
- **Modular 3D Block Signboard**: Constructed using custom uppercase 3D wooden letter blocks (`expedition_assets:letter_*`).
- **Customizable Title**:
  - Default: `/spawn_park_entry` creates `PARQUE DE DINOSAURIOS`.
  - Custom: `/spawn_park_entry JURASSIC|RESERVE` or `/spawn_park_entry EXPEDITION|OUTPOST`.

### 🗼 3. High Hide Observation Tower (`/spawn_observation_tower`)
Based on `reference_images/observation-tower.png`:
- **Dimensions**: 15×15 ground footprint, 25 blocks tall (Y=0 to 24).
- **Architecture**: Heavy reinforced stone-brick footing pads, 4 tapered structural steel truss legs connected by horizontal perimeter bracing rings at Y=4, Y=8, and Y=12.
- **Access & Levels**:
  - Central vertical access ladder encased in an iron safety cage running from the ground to the cabin.
  - Mid-level staging catwalk (7×7) at Y=12 with steel perimeter railings.
  - Enclosed observation cabin (7×7) at Y=15 with 360° reinforced glass panorama, radar & furnace consoles, reference library, illumination, and an **Expedition Supply Box**.
  - Tiered hipped wooden canopy roof with overhanging eaves (Y=19..20).
  - Rooftop communications mast and high-visibility apex beacon light (Y=21..24).
  - Ground pathway with dedicated direction signpost (`Observation Tower`).

---

## ⌨️ Commands & Privileges

| Command | Privileges | Function |
| :--- | :--- | :--- |
| `/ea_apply_skin <skin> [player]` | *(Self: None / Target: `ea_builder`)* | Applies skin and toggles 3D hat. |
| `/ea_spawn_npc <name\|all>` | `ea_builder` | Spawns peaceful NPCs in front of caller. |
| `/spawn_research_station` | `ea_builder` | Constructs the 2-storey outpost facing player. |
| `/spawn_park_entry [L1\|L2]` | `ea_builder` | Constructs the giant archway with letter blocks. |
| `/spawn_observation_tower` | `ea_builder` | Constructs the 25-block tall high-hide observation tower facing player. |

---

## 🛠️ Asset Pipeline

The mod includes an automated Python generator located in `dev/build_assets.py`:
- Converts and scales raw Kenney models from `source/models/` to Luanti node coordinates (`models/`).
- Generates UV-mapped 3D safari hat geometries.
- Synthesizes 64×32 and 64×64 pixel-art character skins.
- Generates 40 custom high-contrast alphabet and numeral signboard blocks.

To rebuild textures and meshes:
```bash
python3 dev/build_assets.py
```

---

## ⚠️ Known Issues & Unfinished / Planned Features

While all core deliverables requested in the specification are fully functional, several enhancements are noted for future releases:

1. **Tent Multi-Block Collision Boundaries**:
   - *Status*: The tent frames and canvas (`tent.obj` / `tent-canvas.obj`) have `walkable = false` with a central selection box so players can comfortably step inside.
   - *Open Improvement*: When placing a tent, an empty 5×4×4 area is validated; however, breaking the primary anchor node currently does not track and clear invisible barrier ghost-nodes over the entire 5×4 footprint. Future versions will implement full multi-node bounding structures.
2. **Double Door Opening Synchronization**:
   - *Status*: The Research Station and Park Gate use native game doors and swung timber leaf nodes.
   - *Open Improvement*: Without extra door mods, double doors open independently rather than swinging in tandem.
3. **NPC Pathfinding & Hostile Fleeing Logic**:
   - *Status*: NPCs support `mobs_redo` and `mcl_mobs` with wandering AI, and include a zero-dependency fallback entity.
   - *Open Improvement*: Under the zero-dependency fallback entity, NPCs stand in place and turn their heads toward players instead of roaming on complex 3D navmeshes.
4. **Signpost Floating Label Draw Distance**:
   - *Status*: Single and double signposts render nametags via an invisible attached billboard entity (`expedition_assets:sign_label`).
   - *Open Improvement*: On servers with strict entity culling settings, text visibility distance depends on client entity view distance settings.
5. **Character Hat Vertical Offset Variations**:
   - *Status*: Hat mesh offset is default tuned (`y = 3.7`) to standard `character.b3d` head bone dimensions.
   - *Open Improvement*: Highly customized third-party player models (slim-arm or alternate armatures) may require tweaking the `expedition_assets_hat_offset_y` setting in `minetest.conf`.

---

## 📜 License & Credits

- **Code & Scripts**: Copyright © 2026 **ronrob-lu**. Licensed under the **MIT License**.
- **3D Source Models**: Assets created by **Kenney** ([kenney.nl](https://kenney.nl)), licensed under **Creative Commons Zero (CC0 1.0 Universal - Public Domain)**.
