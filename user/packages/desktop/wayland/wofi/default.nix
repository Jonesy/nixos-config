{ pkgs, userSettings, ... }: {
  home.packages = with pkgs; [ wofi ];
  programs.wofi = {
    enable = true;
    settings = {
      allow_markup = true;
      width = "25%";
      height = "25%";
    };
    style = ''
      @define-color dark-1 #211e20;
      @define-color dark-2 #555568;
      @define-color light-1 #a0a08b;
      @define-color light-2 #e9efec;

      * {
        font-family: "${userSettings.fontFamilyGui}", monospace;
        font-size: 18px;
      }

      window {
        color: @light-1;
        background-color: @dark-1;
        border-radius: 0.1rem;
      }

      #inner-box {
        padding: 5px;
      }

      #outer-box {
        padding: 5px;
      }

      #input {
        margin: 5px;
        border-radius: 0;
        color: @dark-2;
        background-color: @dark-1;
        border: 2px solid @dark-1;
      }

      #input:focus {
        color: @light-2;
      }

      #input:focus>* {
        border: none;
        outline: none;
      }

      #entry {
        border-radius: 0;
      }

      #entry:selected {
        background-color: @light-1;
        outline: none;
      }

      #text:selected {
        color: @dark-1;
        outline: none;
      }
    '';
  };
}

