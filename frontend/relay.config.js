"use strict";

const path = require("path");
const APP_PATH = path.join(__dirname, "src");

module.exports = {
    src: APP_PATH,
    schema: path.join(APP_PATH, "schema.graphql"),
    language: "typescript",
    customScalars: {
        "DateTimeUtc": "string",
        "Cursor": "string",
        "ExtraMetadata": "Record<string, Record<string, string[]>>",
    },
    schemaExtensions: [APP_PATH],
};
