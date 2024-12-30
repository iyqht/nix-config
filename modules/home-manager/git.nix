{
  programs.git = {
    enable = true;
    userEmail = "tranhoangkhanhvta@gmail.com";
    userName = "iyqht";
    aliases = {
      co = "checkout";
    };
    extraConfig = {
      credential = {
        helper = "manager";
        credentialStore = "gpg";
        "https://github.com".username = "iyqht";
      };
    };
  };
}
