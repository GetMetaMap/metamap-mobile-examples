'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

const index = require('./index-2a75be79.js');
const ionicGlobal = require('./ionic-global-e00fdf4a.js');
const theme = require('./theme-30b7a575.js');

const textCss = ":host(.ion-color){color:var(--ion-color-base)}";

const Text = class {
  constructor(hostRef) {
    index.registerInstance(this, hostRef);
  }
  render() {
    const mode = ionicGlobal.getIonMode(this);
    return (index.h(index.Host, { class: theme.createColorClasses(this.color, {
        [mode]: true,
      }) }, index.h("slot", null)));
  }
};
Text.style = textCss;

exports.ion_text = Text;
