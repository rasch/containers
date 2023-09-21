/****************************************************
 * Surf user scripts
 *
 * keybindings
 * -----------
 * j    scroll down
 * k    scroll up
 * h    scroll left
 * l    scroll right
 * g    scroll to top of page
 * G    scroll to bottom of page
 * f    toggle link hints
 * F    toggle link hints (to open in new window)
 * C-s  toggle simplyread
 *
 ****************************************************/

;(() => {
  if (window.__userScriptsLoaded__) return

  let links = []
  let hintModeEnabled = false
  let newWindow = false
  let selected = ""

  const handleSelectedLink = ({ key }) => {
    if (/[0-9]/.test(key)) {
      selected += key
    } else if (key === "Backspace") {
      selected = selected.slice(0, -1)
    }

    links.forEach(link => {
      if (link.getAttribute("data-hint-label") === selected) {
        link.classList.add("surf-link-hints-selected")
        if (key === "Enter") {
          if (newWindow) {
            link.setAttribute("target", "_blank")
          } else {
            link.removeAttribute("target")
          }
          toggleHintMode()
          link.click()
        }
      } else {
        link.classList.remove("surf-link-hints-selected")
      }
    })
  }

  const enableHintMode = () => {
    links = Array.from(document.querySelectorAll("a[href]"))

    links.forEach((link, id) => {
      link.setAttribute("data-hint-label", id + 1)
      link.classList.add("surf-link-hints")
    })

    window.addEventListener("keypress", handleSelectedLink)
  }

  const disableHintMode = () => {
    links.forEach(link => {
      link.removeAttribute("data-hint-label")
      link.classList.remove("surf-link-hints", "surf-link-hints-selected")
    })

    window.removeEventListener("keypress", handleSelectedLink)
    newWindow = false
    selected = ""
  }

  const toggleHintMode = () =>
    (hintModeEnabled = !hintModeEnabled) ? enableHintMode() : disableHintMode()

  const isEditable = ({ nodeName, type, contentEditable }) =>
    nodeName.toLowerCase() === "textarea" ||
    (nodeName.toLowerCase() === "input" && type === "text") ||
    document.designMode === "on" ||
    contentEditable === "true"

  const scrollBy = left => top =>
    window.scrollBy({ left, top, behavior: "smooth" })

  const scrollTo = left => top =>
    window.scrollTo({ left, top, behavior: "smooth" })

  const actions = {
    k: () => scrollBy(0)(-32),
    j: () => scrollBy(0)(32),
    h: () => scrollBy(-32)(0),
    l: () => scrollBy(32)(0),
    g: () => scrollTo(0)(0),
    G: () => scrollTo(0)(document.documentElement.scrollHeight),
    f: () => {
      newWindow = false
      toggleHintMode()
    },
    F: () => {
      newWindow = true
      toggleHintMode()
    },
    "C-s": simplyread,
  }

  const handleKeypress = ({ target, ctrlKey, altKey, key }) => {
    if (isEditable(target)) return

    const keybinding = (ctrlKey ? "C-" : "") + (altKey ? "A-" : "") + key
    const fn = actions[keybinding]

    if (typeof fn === "function") fn()
  }

  window.addEventListener("keypress", handleKeypress)
  window.__userScriptsLoaded__ = true
})()
