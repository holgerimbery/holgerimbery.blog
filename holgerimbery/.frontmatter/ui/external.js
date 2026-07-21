//import { registerCardImage, enableDevelopmentMode } from "https://cdn.jsdelivr.net/npm/@frontmatter/extensibility/+esm";
// enableDevelopmentMode();
//registerCardImage(async (filePath, metadata) => {
//    const image = metadata.image || (await getImageFromFile(filePath));
//    return `<img src="${image}" alt="${metadata.title}" style="object-fit: cover; margin: auto auto" class="h-36" />`;
//});
import { registerCardImage, enableDevelopmentMode } from "https://cdn.jsdelivr.net/npm/@frontmatter/extensibility/+esm";
// enableDevelopmentMode();

/**
 * @param {string} filePath - The path of the file
 * @param {object} data - The metadata of the file
 * @returns {string} - The HTML to be rendered in the card footer
 */
registerCardImage(async (filePath, metadata) => {
    const image = metadata.image || (await getImageFromFile(filePath));
    return `<img src="${image}" alt="${metadata.title}" style="object-fit: cover; margin: auto auto" class="h-36" />`;
});