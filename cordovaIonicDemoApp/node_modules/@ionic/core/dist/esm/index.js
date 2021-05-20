import './index-3ccd7557.js';
export { g as getPlatforms, i as initialize, a as isPlatform } from './ionic-global-ddef3a45.js';
export { c as componentOnReady } from './helpers-dd7e4b7b.js';
export { c as createAnimation } from './animation-096c6391.js';
export { a as LIFECYCLE_DID_ENTER, c as LIFECYCLE_DID_LEAVE, L as LIFECYCLE_WILL_ENTER, b as LIFECYCLE_WILL_LEAVE, d as LIFECYCLE_WILL_UNLOAD } from './index-899f6740.js';
export { iosTransitionAnimation } from './ios.transition-acb8ffe9.js';
export { mdTransitionAnimation } from './md.transition-390786c3.js';
export { g as getTimeGivenProgression } from './cubic-bezier-eea9a7a9.js';
import './gesture-controller-31cb6bb9.js';
export { createGesture } from './index-f49d994d.js';
export { I as IonicSafeString } from './index-9e3fe806.js';
import './hardware-back-button-4a6b37fb.js';
export { m as menuController } from './index-3432b520.js';
export { b as actionSheetController, a as alertController, l as loadingController, m as modalController, p as pickerController, c as popoverController, t as toastController } from './overlays-738d7bc9.js';

const setupConfig = (config) => {
  const win = window;
  const Ionic = win.Ionic;
  if (Ionic && Ionic.config && Ionic.config.constructor.name !== 'Object') {
    console.error('ionic config was already initialized');
    return;
  }
  win.Ionic = win.Ionic || {};
  win.Ionic.config = Object.assign(Object.assign({}, win.Ionic.config), config);
  return win.Ionic.config;
};
const getMode = () => {
  const win = window;
  const config = win && win.Ionic && win.Ionic.config;
  if (config) {
    if (config.mode) {
      return config.mode;
    }
    else {
      return config.get('mode');
    }
  }
  return 'md';
};

export { getMode, setupConfig };
