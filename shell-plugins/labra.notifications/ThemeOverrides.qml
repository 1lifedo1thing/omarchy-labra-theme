import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons

// Read Labra at its source, including after shell restarts, without staging files.
Item {
  id: root
  property bool active: false

  FileView {
    path: Color.stateHome + "/omarchy/current/theme.name"
    watchChanges: true
    printErrors: false
    onFileChanged: reload()
    onLoaded: {
      root.active = text().trim() === "labra"
      Color.shellFile.path = root.active
        ? Quickshell.env("HOME") + "/.config/omarchy/themes/labra/shell.toml"
        : Color.currentThemePath + "/shell.toml"
      Color.shellFile.watchChanges = root.active
    }
  }

  Connections {
    target: Color.shellFile
    function onFileChanged() {
      if (root.active) Color.shellFile.reload()
    }
  }
}
