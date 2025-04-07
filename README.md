# Distributed Spectral Ruleset

This repository contains a distributed Spectral ruleset that you can use for linting your OpenAPI Specifications.

## Documentation

You can serve the documentation (index.html) locally to view the ruleset documentation.

```bash
php -S localhost:8000
open http://localhost:8000
```

## Testing One-Off Rules

```bash
./scripts/rule-test.sh
```

## Linting a Specification

```bash
# basic CLI lint
npx @quobix/vacuum lint -d ./examples/specs/bundled/openapi.json
# open CLI dashboard tool to interact with lint report
npx @quobix/vacuum dashboard ./examples/specs/bundled/openapi.json
# generate HTML lint report
npx @quobix/vacuum html-report ./examples/specs/bundled/openapi.json
```

### Other Linting Options

#### Spectral

```bash
echo "extends: [[spectral:oas, recommended]]" >> ./examples/specs/bundled/.spectral.yml
npx @stoplight/spectral lint -r ./examples/specs/bundled/.spectral.yml --format=stylish ./examples/specs/bundled/openapi.json
rm ./examples/specs/bundled/.spectral.yml
```

#### Redocly

```bash
npx @redocly/cli lint ./examples/specs/bundled/openapi.json
```

#### Swagger CLI

```bash
npx @apidevtools/swagger-cli validate ./examples/specs/bundled/openapi.json
```

## Example Files

### Specifications

There are 2 equivalent OAS Petstore examples provided with this ruleset.

```bash
# temporary bundle the unbundled spec
npx @redocly/cli bundle ./examples/specs/unbundled/openapi.json --output ./examples/specs/unbundled/openapi-bundled.json
# count the number of diff lines (should be 0 because they are equivalent)
diff ./examples/specs/bundled/openapi.json ./examples/specs/unbundled/openapi-bundled.json | wc -l
# remove the temporary bundle
rm ./examples/specs/unbundled/openapi-bundled.json
```