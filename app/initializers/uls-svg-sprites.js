const SVG_SPRITES = [
  'guls-svg-icons.svg',
  'editor-icons.svg',
  'editor-empty-icons.svg',
  'editor-empty-icons1.svg',
  'editor-empty-icons2.svg',
  'editor-empty-icons3.svg',
  'editor-empty-icons4.svg',
  'editor-empty-icons5.svg',
];

function injectSvgSprite(svgMarkup) {
  const wrapper = document.createElement('div');
  wrapper.className = 'uls-multi-clr-svg hidden';
  wrapper.innerHTML = svgMarkup;
  document.body.appendChild(wrapper);
}

export function initialize() {
  SVG_SPRITES.forEach((fileName) => {
    fetch(`/images/${fileName}`)
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Could not load /images/${fileName}`);
        }

        return response.text();
      })
      .then(injectSvgSprite)
      .catch(() => {
        // ULS images are optional when Eventz ULS is not on disk.
      });
  });
}

export default {
  initialize,
};
