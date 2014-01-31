(function() {
  angular.module('myApp', []);

}).call(this);

(function() {
  var NavController;

  NavController = (function() {
    NavController.$inject = ['$scope'];

    function NavController(scope) {
      this.scope = scope;
      this.scope.testtitle = 'Simple title changed';
    }

    return NavController;

  })();

  angular.module('myApp').controller('NavController', NavController);

}).call(this);

(function() {
  var OtherController;

  OtherController = (function() {
    OtherController.$inject = ['$scope'];

    function OtherController(scope) {
      this.scope = scope;
      this.scope.testtitle = 'Another Simple title';
    }

    return OtherController;

  })();

  angular.module('myApp').controller('OtherController', OtherController);

}).call(this);

(function() {
  var AudioPlayer, NavDirective;

  NavDirective = (function() {
    function NavDirective() {}

    NavDirective.primaryoptions = function() {
      return {
        restrict: "E",
        templateUrl: "primarynav.tmpl",
        scope: {
          navtitle: "@"
        }
      };
    };

    NavDirective.secondaryoptions = function() {
      return {
        restrict: "E",
        templateUrl: "secondarynav.tmpl",
        scope: {
          navtitle: "@"
        }
      };
    };

    return NavDirective;

  })();

  angular.module('myApp').directive('primarynav', NavDirective.primaryoptions);

  angular.module('myApp').directive('secondarynav', NavDirective.secondaryoptions);

  AudioPlayer = (function() {
    var formatSecondsAsTime, getCurrentProgressValue, link;

    function AudioPlayer() {}

    formatSecondsAsTime = function(secs) {
      var hours, minutes, seconds;
      hours = Math.floor(secs / 3600);
      minutes = Math.floor((secs - (hours * 3600)) / 60);
      seconds = Math.floor(secs - (hours * 3600) - (minutes * 60));
      if (seconds < 10) {
        seconds = "0" + seconds;
      }
      return minutes + ":" + seconds;
    };

    getCurrentProgressValue = function(audio) {
      var progressValue;
      console.log(audio.duration);
      console.log(audio.buffered.end(0));
      if (audio.duration === NaN) {
        progressValue = 0;
      } else {
        progressValue = (audio.buffered.end(0) / audio.duration) * 100;
      }
      console.log("progress: " + progressValue);
      return progressValue;
    };

    link = function($scope, element, attrs) {
      var audio;
      audio = new Audio();
      audio.addEventListener('loadedmetadata', function() {
        var label;
        label = angular.element(document.getElementById("duration-label"));
        return label.html(formatSecondsAsTime(audio.duration));
      });
      audio.addEventListener('progress', function() {
        var progress;
        progress = angular.element(document.getElementById("duration-progress"));
        return progress[0].value = getCurrentProgressValue(audio);
      });
      audio.addEventListener('timeupdate', function() {
        var label;
        label = angular.element(document.getElementById("duration-label"));
        return label.html(formatSecondsAsTime(audio.duration));
      });
      $scope.audio = audio;
      attrs.$observe('audioSrc', function(value) {
        audio.src = value;
        audio.controls = "controls";
        audio.style.width = 0;
        audio.volume = 0.5;
        audio.preload = "auto";
        return element[0].appendChild(audio);
      });
      $scope.playpause = function() {
        if (audio.paused) {
          return audio.play();
        } else {
          return audio.pause();
        }
      };
      return $scope.changevolume = function() {
        var inputs;
        inputs = element.find("input");
        return audio.volume = inputs[0].value;
      };
    };

    AudioPlayer.options = function() {
      return {
        restrict: "E",
        templateUrl: "audio-player.tmpl",
        replace: true,
        link: link
      };
    };

    return AudioPlayer;

  })();

  angular.module('myApp').directive('audioplayer', AudioPlayer.options);

}).call(this);
