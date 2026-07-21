import { registerCardImage, enableDevelopmentMode } from "https://cdn.jsdelivr.net/npm/@frontmatter/extensibility/+esm";
// enableDevelopmentMode();
registerCardImage(async (filePath, metadata) => {
    const image = metadata.image || (await getImageFromFile(filePath));
    return `<img src="${image}" alt="${metadata.title}" style="object-fit: cover; margin: auto auto" class="h-36" />`;
});