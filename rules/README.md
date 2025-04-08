# Rules

This collection of rules was crafted with reuse and readability in mind. When contributing to this collection, please keep the following conventions in mind.

## Naming Convention

| Type | Pattern | Convention |
|------|---------|------------|
| Inclusion | "if `x` is missing `y`, then throw an error." | `{file}-{x}-missing-{y}` |
| Invalid | "if `x` is not `y`, then throw an error." | `{file}-{x}-not-{y}` |
| Exclusion | "if `x` has `y`, then throw an error." | `{file}-{x}-has-{y}` |

### Parameters

- `{file}` - the file where the rule is defined
- `{x}` - an OAS field (can be compound, moving from lowres to highres) (e.g. response-patch-code)
- `{y}` - an OAS field (can be compound, moving from lowres to highres) (e.g. header-x-stplus-request-id); can also be a rule (e.g. camel-case)

## File Convention

Rules are organized into the following YAML files based on their purpose:

| File | Description |
|------|-------------|
| `data.yml` | Rules related to data types (null, object, array, primitives) |
| `naming.yml` | Rules related to naming conventions (e.g. snake_case) |
| `path.yml` | Rules related to paths |
| `request.yml` | Rules related to requests (headers, params, bodies, security) |
| `response.yml` | Rules related to responses (headers, responses) |
| `schema.yml` | Rules related to generic schemas |

## Testing

Each rule uses JSONPath to match parts of a specification for linting purposes. To easily test JSONPaths, use the [JSONPath Online Evaluator](https://jsonpath.com/).