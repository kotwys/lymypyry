let
  themes = {
    base2tone-motel = {
      a0 = "#242323";
      a1 = "#373434";
      a2 = "#5a5354";
      a3 = "#766b6c";
      a4 = "#86797b";
      a5 = "#94898b";
      a6 = "#a5979a";
      a7 = "#b3a8aa";
      b0 = "#674c50";
      b1 = "#7d5e63";
      b2 = "#956f76";
      b3 = "#a7868b";
      b4 = "#b89da2";
      b5 = "#ccb3b7";
      b6 = "#dec9cc";
      b7 = "#f0dbdf";
      c0 = "#847875";
      c1 = "#978a87";
      c2 = "#a89c99";
      c3 = "#b9aeac";
      c4 = "#cac0be";
      c5 = "#dcd2d0";
      c6 = "#ede5e3";
      c7 = "#fbf9f9";
      d0 = "#e24f32";
      d1 = "#ea5f43";
      d2 = "#f6684c";
      d3 = "#f77c64";
      d4 = "#f8917c";
      d5 = "#ffa28f";
      d6 = "#ffb3a3";
      d7 = "#ffc8bd";
    };
  };

  mkDark = palette: {
    "ui.background" = {
      fg = palette.a5;
      bg = palette.a0;
    };
    "ui.text" = palette.c7;

    "ui.cursor.match" = {
      bg = palette.a0;
      fg = palette.d4;
      modifiers = ["underlined"];
    };

    "ui.linenr" = palette.a2;
    "ui.linenr.selected" = palette.a3;
    "ui.selection" = {
      bg = palette.a1;
    };
    "ui.statusline" = {
      fg = palette.c6;
      bg = palette.a1;
    };
    "ui.statusline.select" = {
      fg = palette.c6;
    };
    "ui.statusline.insert" = {
      fg = palette.c2;
    };
    "ui.statusline.normal" = {
      fg = palette.d6;
    };

    "ui.virtual.whitespace" = palette.a2;
    "ui.virtual.indent-guide" = palette.a2;

    "ui.menu" = {
      bg = palette.a1;
      fg = palette.a5;
    };
    "ui.menu.selected" = {
      bg = palette.d4;
      fg = palette.a0;
    };

    "ui.popup" = {
      bg = palette.d0;
      fg = palette.a0;
    };

    "ui.help" = {
      bg = palette.d0;
      fg = palette.a0;
    };
    "ui.text.info" = palette.a0;

    "comment" = {
      fg = palette.a3;
      modifiers = ["italic"];
    };
    "punctuation" = palette.a4;

    "type" = {
      fg = palette.d7;
      modifiers = ["italic"];
    };
    "attribute" = palette.d5;

    "variable" = palette.b5;
    "constant" = palette.d7;
    "string" = palette.d5;
    "constant.character" = palette.d5;

    "keyword" = palette.b2;
    "keyword.operator" = palette.d2;
    "keyword.control" = palette.d2;
    "keyword.directive" = palette.a4;

    "tag" = palette.b7;
    "function" = palette.b7;

    "markup.heading" = palette.d5;
    "markup.list" = palette.b0;

    "markup.bold" = {
      fg = palette.d4;
      modifiers = ["bold"];
    };
    "markup.italic" = {
      fg = palette.b2;
      modifiers = ["italic"];
    };
    "markup.raw.inline" = palette.c0;
    "markup.quote" = palette.d2;
    "markup.link" = {
      fg = palette.d6;
      modifiers = ["underlined"];
    };
  };
in
  builtins.mapAttrs (_: mkDark) themes