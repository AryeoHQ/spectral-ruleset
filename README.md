# Distributed Spectral Ruleset

This repository contains a distributed Spectral ruleset that you can use for linting your OpenAPI Specifications.

## Documentation

You can serve the documentation (index.html) locally to view the ruleset documentation.

```bash
php -S localhost:8000
open http://localhost:8000
```

## Linting

```bash
# basic CLI lint
npx @quobix/vacuum lint -d ./examples/specs/bundled/Bundled.json
# open CLI dashboard tool to interact with lint report
npx @quobix/vacuum dashboard ./examples/specs/bundled/Bundled.json
# generate HTML lint report
npx @quobix/vacuum html-report ./examples/specs/bundled/Bundled.json
```

### Other Options

#### Spectral

```bash
echo "extends: [[spectral:oas, recommended]]" >> ./examples/specs/bundled/.spectral.yml
npx @stoplight/spectral lint -r ./examples/specs/bundled/.spectral.yml --format=stylish ./examples/specs/bundled/Bundled.json
rm ./examples/specs/bundled/.spectral.yml
```

#### Redocly

```bash
npx @redocly/cli lint ./examples/specs/bundled/Bundled.json
```

#### Swagger CLI

```bash
npx @apidevtools/swagger-cli validate ./examples/specs/bundled/Bundled.json
```

## Examples

### Specifications

There are 2 equivalent OAS Petstore examples:

```bash
# temporary bundle the unbundled spec
npx @redocly/cli bundle ./examples/specs/unbundled/Unbundled.json --output ./examples/specs/unbundled/Unbundled-Bundled.json
# count the number of diff lines (should be 0)
diff ./examples/specs/bundled/Bundled.json ./examples/specs/unbundled/Unbundled-Bundled.json | wc -l
# remove the temporary bundle
rm ./examples/specs/unbundled/Unbundled-Bundled.json
```