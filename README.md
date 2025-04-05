# css-tools.nvim

A Neovim plugin designed to enhance your CSS development workflow using LSP features provided by `cssls`.

## Features

- Add custom CSS definitions (properties, at-rules, pseudo classes and elements)

## Installation

To install `css-tools.nvim`, you can use your preferred plugin manager. For example, using `lazy.nvim`:

```lua
return {
    "steschwa/css-tools.nvim",
    opts = {
        -- see below for the full configuration reference
    }
}
```

## Configuration

Once installed, `css-tools.nvim` needs to be configured to function properly:

```lua
{
    customData = {
        "/absolute/path/to/your/data.json",
        "relative/path/to/your/data.json",
        "https://remote-path.com/your-data.json"
    },
}
```

### Parameters

- `customData` (table<string>): A list of file paths (relative or absolute) or urls (http or https) pointing to your custom data files.
  See [https://github.com/microsoft/vscode-css-languageservice/blob/main/docs/customData.md](https://github.com/microsoft/vscode-css-languageservice/blob/main/docs/customData.md)
  and [https://github.com/microsoft/vscode-custom-data](https://github.com/microsoft/vscode-custom-data) for more information.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
