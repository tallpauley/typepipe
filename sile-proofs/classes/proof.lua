local plain = SILE.require("plain", "classes")
local proof = plain { id = "proof" }
SILE.scratch.proof = {}

proof:loadPackage("masters")
proof:defineMaster({
    id = "characters",
    firstContentFrame = "content",
    frames = {
      content = {
        left = ".5in",
        right = "10.5in",
        top = ".5in",
        bottom = "8in"
      },
      headerLeft = {
        left = "left(content)",
        right = "50%pw",
        top = "top(content)-.25in",
        bottom = "top(content)"
      },
      headerRight = {
        left = "right(headerLeft)",
        right = "right(content)",
        top = "top(headerLeft)",
        bottom = "bottom(topLeft)"
      },
      footerLeft = {
        left = "left(headerLeft)",
        right = "right(headerLeft)",
        top = "bottom(content)+.25in",
        height = ".25in"
      },
      footerRight = {
        left = "left(headerRight)",
        right = "right(headerRight)",
        top = "top(footerLeft)",
        height = "bottom(footerLeft)"
      }
    }
  })

proof.init = function (self)
  proof.pageTemplate = SILE.scratch.masters["characters"]
  return plain.init(self)
end

proof.endPage = function (_)

  if (SILE.scratch.proof.headerLeft) then
    SILE.typesetNaturally(SILE.getFrame("headerLeft"), function ()
      SILE.process(SILE.scratch.proof.headerLeft)
      SILE.call("par")
    end)
  end

  if (SILE.scratch.proof.headerRight) then
    SILE.typesetNaturally(SILE.getFrame("headerRight"), function ()
      SILE.process(SILE.scratch.proof.headerRight)
      SILE.call("par")
    end)
  end

  if (SILE.scratch.proof.footerLeft) then
    SILE.typesetNaturally(SILE.getFrame("footerLeft"), function ()
      SILE.process(SILE.scratch.proof.footerLeft)
      SILE.call("par")
    end)
  end

  if (SILE.scratch.proof.footerRight) then
    SILE.typesetNaturally(SILE.getFrame("footerRight"), function ()
      SILE.process(SILE.scratch.proof.footerRight)
      SILE.call("par")
    end)
  end

  return plain.endPage(book)
end

SILE.registerCommand("header-right", function (_, content)
    local closure = SILE.settings.wrap()
    SILE.scratch.proof.headerRight = function () closure(content) end
  end, "Content to appear at top right of page")

SILE.registerCommand("header-left", function (_, content)
    local closure = SILE.settings.wrap()
    SILE.scratch.proof.headerLeft = function () closure(content) end
  end, "Content to appear at top right of page")
  
SILE.registerCommand("footer-left", function (_, content)
    local closure = SILE.settings.wrap()
    SILE.scratch.proof.footerLeft = function () closure(content) end
  end, "Content to appear at top right of page")

SILE.registerCommand("footer-right", function (_, content)
    local closure = SILE.settings.wrap()
    SILE.scratch.proof.footerRight = function () closure(content) end
  end, "Content to appear at top right of page")

SILE.registerCommand("env", function (options, _)
    SILE.typesetter:typeset(os.getenv(options.name))
  end, "Insert an environment variable in the text")
  

return proof