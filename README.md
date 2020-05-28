# Code Examples

This repo contains code snippets that can be shared across documentation
and to be run by our lovely customers.


## Files structure

Repo contains two main entry points:

- [content-by-language](https://github.com/vgs-samples/code-examples/tree/master/content-by-language)
- [mixed-content](https://github.com/vgs-samples/code-examples/tree/master/mixed-content)

### `content-by-language` folder

This folder contains code snippets grouped by the target language
they are written on. 

Please observe folder with a specific language
you interested in for some examples.

Currently, there are such code languages available:

- [bash](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/bash)
- [go](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/go)
- [html](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/html)
- [java](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/java)
- [node](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/node)
- [php](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/php)
- [python](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/python)
- [ruby](https://github.com/vgs-samples/code-examples/tree/master/content-by-language/ruby)

### `mixed-content` folder

This folder is for a related content on different languages which should be 
stored within some common folder. For example some set of configuration files
for initial product setup, etc.


## Reveal content from this repo inside docs repo

### Reveal content in docs repo by name

To add the content from this repo inside docs repo, just plug such code
snippet inside `.mdx` page whenever this needed.

```jsx
<CodeFrom>
`inbound-integration`
</CodeFrom>
```

`inbound-integration` here marks an id name that will be searched across
`content-by-language/**/inbound-integration.*` path. All the matched result
will be rendered as an appropriate code blocks separated by tabs.

### Reveal content in docs repo by specific folder

To add all the content from specific folder to docs repo, just plug next code snippet into
the specific `.mdx` file:

```jsx
<CodeFrom options={{ isMixedContent: true }}>
`inbound-integration`
</CodeFrom>
```

### [Is Coming Soon] Reveal partial content in docs repo (specific lines range for a file)

```jsx
<CodeFrom options={{ lines: { "inbound-integration.js": [10, 20]} }}>
`inbound-integration`
</CodeFrom>
```

In such case for dedicated `.js` file only these specific lines range will be shown. For other
files that are not mentioned in this config all the content will be shown by default.

For more information on integration with a Docs repo, please refer [here](https://github.com/verygoodsecurity/docs/blob/master/README.md)
