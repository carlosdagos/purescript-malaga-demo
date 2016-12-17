"use strict";

// module Examples.Foreign

var lodash = require('lodash')

exports.reverse = function (arr) {
    return lodash.reverse(arr)
}

exports.slice = function(arr) {
    return function (start) {
        return function (end) {
            return lodash.slice(arr, start, end)
        }
    }
}

// so on... :)
