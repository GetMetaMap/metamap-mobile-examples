(function () {
  (window["webpackJsonp"] = window["webpackJsonp"] || []).push([["status-tap-3a499f55-js"], {
    /***/
    "dL/K":
    /*!******************************************************************!*\
      !*** ./node_modules/@ionic/core/dist/esm/status-tap-3a499f55.js ***!
      \******************************************************************/

    /*! exports provided: startStatusTap */

    /***/
    function dLK(module, __webpack_exports__, __webpack_require__) {
      "use strict";

      __webpack_require__.r(__webpack_exports__);
      /* harmony export (binding) */


      __webpack_require__.d(__webpack_exports__, "startStatusTap", function () {
        return startStatusTap;
      });
      /* harmony import */


      var _index_3ccd7557_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
      /*! ./index-3ccd7557.js */
      "2atR");
      /* harmony import */


      var _helpers_dd7e4b7b_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
      /*! ./helpers-dd7e4b7b.js */
      "1vRN");

      var startStatusTap = function startStatusTap() {
        var win = window;
        win.addEventListener('statusTap', function () {
          Object(_index_3ccd7557_js__WEBPACK_IMPORTED_MODULE_0__["f"])(function () {
            var width = win.innerWidth;
            var height = win.innerHeight;
            var el = document.elementFromPoint(width / 2, height / 2);

            if (!el) {
              return;
            }

            var contentEl = el.closest('ion-content');

            if (contentEl) {
              new Promise(function (resolve) {
                return Object(_helpers_dd7e4b7b_js__WEBPACK_IMPORTED_MODULE_1__["c"])(contentEl, resolve);
              }).then(function () {
                Object(_index_3ccd7557_js__WEBPACK_IMPORTED_MODULE_0__["c"])(function () {
                  return contentEl.scrollToTop(300);
                });
              });
            }
          });
        });
      };
      /***/

    }
  }]);
})();
//# sourceMappingURL=status-tap-3a499f55-js-es5.js.map