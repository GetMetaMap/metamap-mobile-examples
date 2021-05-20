'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

require('./index-2a75be79.js');
const ionicGlobal = require('./ionic-global-e00fdf4a.js');
const helpers = require('./helpers-d381ec4d.js');
const animation = require('./animation-13cbbb20.js');
const index$2 = require('./index-c7f927fd.js');
const ios_transition = require('./ios.transition-cc09c708.js');
const md_transition = require('./md.transition-22653eb0.js');
const cubicBezier = require('./cubic-bezier-0b2ccc35.js');
require('./gesture-controller-29adda71.js');
const index = require('./index-98d43f07.js');
const index$1 = require('./index-e1bb33c3.js');
require('./hardware-back-button-148ce546.js');
const index$3 = require('./index-137fdcc8.js');
const overlays = require('./overlays-b9bea3ba.js');

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

exports.getPlatforms = ionicGlobal.getPlatforms;
exports.initialize = ionicGlobal.initialize;
exports.isPlatform = ionicGlobal.isPlatform;
exports.componentOnReady = helpers.componentOnReady;
exports.createAnimation = animation.createAnimation;
exports.LIFECYCLE_DID_ENTER = index$2.LIFECYCLE_DID_ENTER;
exports.LIFECYCLE_DID_LEAVE = index$2.LIFECYCLE_DID_LEAVE;
exports.LIFECYCLE_WILL_ENTER = index$2.LIFECYCLE_WILL_ENTER;
exports.LIFECYCLE_WILL_LEAVE = index$2.LIFECYCLE_WILL_LEAVE;
exports.LIFECYCLE_WILL_UNLOAD = index$2.LIFECYCLE_WILL_UNLOAD;
exports.iosTransitionAnimation = ios_transition.iosTransitionAnimation;
exports.mdTransitionAnimation = md_transition.mdTransitionAnimation;
exports.getTimeGivenProgression = cubicBezier.getTimeGivenProgression;
exports.createGesture = index.createGesture;
exports.IonicSafeString = index$1.IonicSafeString;
exports.menuController = index$3.menuController;
exports.actionSheetController = overlays.actionSheetController;
exports.alertController = overlays.alertController;
exports.loadingController = overlays.loadingController;
exports.modalController = overlays.modalController;
exports.pickerController = overlays.pickerController;
exports.popoverController = overlays.popoverController;
exports.toastController = overlays.toastController;
exports.getMode = getMode;
exports.setupConfig = setupConfig;
