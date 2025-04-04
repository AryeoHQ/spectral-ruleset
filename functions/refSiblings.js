// SOURCE: https://github.com/stoplightio/spectral/blob/3797272fcf44ea4a7a27f881728170ea240c89aa/packages/rulesets/src/oas/functions/refSiblings.ts#L29
// We converted the built-in `refSiblings` function from TS to JS so that it would work alongside our YAML-based rulesets.
// We also needed to modify the rule declaration so that it could run on "componentized" spec files.
import { createRulesetFunction } from '@stoplight/spectral-core'

function isObject(value) {
  return value !== null && typeof value === 'object'
}

function getParentValue(document, path) {
  if (path.length === 0) {
    return null
  }

  let piece = document

  for (let i = 0; i < path.length - 1; i += 1) {
    if (!isObject(piece)) {
      return null
    }

    piece = piece[path[i]]
  }

  return piece
}

export default createRulesetFunction(
  {
    input: null,
    options: null,
  },
  (targetVal, options, { document, path }) => {
    const value = getParentValue(document.data, path)
    if (!isObject(value)) return

    const keys = Object.keys(value)
    if (keys.length === 1) {
      return
    }

    const results = []
    const actualObjPath = path.slice(0, -1)

    for (const key of keys) {
      if (key === '$ref') {
        continue
      }
      results.push({
        message: '$ref must not be placed next to any other properties',
        path: [...actualObjPath, key],
      })
    }

    return results
  }
)
