1. Modify `register_tent` in `src/tents.lua` to accept a `walkable` boolean parameter.
2. Change the hardcoded `walkable = false` to `walkable = walkable`.
3. Update the `register_tent("tent", ...)` call to pass `false` for `walkable`.
4. Update the `register_tent("tent_canvas", ...)` call to pass `true` for `walkable`, making the tent with canvas not passable (solid).
5. Complete pre commit steps to make sure proper testing, verifications, reviews and reflections are done.
