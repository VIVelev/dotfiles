import XMonad
import XMonad.Util.EZConfig ( additionalKeys )

import qualified Data.Map as M

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. controlMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask,               , xK_w     ), kill)
    ]

main :: IO ()
main = xmonad $ def
    { modMask  = mod4Mask  -- Rebind Mod to the Super key
    , terminal = "kitty"   -- Change the default terminal app to Kitty
    } `additionalKeys` myKeys
