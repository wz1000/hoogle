{-# LANGUAGE RecordWildCards #-}
module Recipe.Base(base) where

import Recipe.Type


base :: RecipeDetails -> [String] -> IO ()
base r@RecipeDetails{..} tag = do
    return ()

{-
import General.Code

    b <- doesFileExist "base.web/base.cabal"
    unless b $ do
        let t = if null tag then "" else "--tag=\"base " ++ head tag ++ "\""
        res <- system $ "darcs2 get --lazy --repo-name=base.web http://darcs.haskell.org/packages/base " ++ t
        unless (res == ExitSuccess) $ error "Failed to download darcs for base"

    basePatchup
    haddock "base"

    (res1,res2) <- liftM splitGHC $ readTextBase $ "temp/base/hoogle.txt"
    let prefix = basePrefix ++ ["@depends ghc"]
    writeFile "result/base.txt" $ unlines $ replaceTextBasePrefix prefix res1
    writeFile "result/ghc.txt" $ unlines $ ghcPrefix ++ res2


basePatchup = do
    -- FIX THE CABAL FILE
    fixupCabal "base" $ \x -> [x | not $ "ghc.prim" `isSubstrOf` map toLower x]

    -- INCLUDE FILE
    copyFile "Config.h" "temp/base/include/HsBaseConfig.h"

seqDocs = 
    ["-- | The value of <tt><a>seq</a> a b</tt> is bottom if <tt>a</tt> is"
    ,"--   bottom, and otherwise equal to <tt>b</tt>. <a>seq</a> is usually"
    ,"--   introduced to improve performance by avoiding unneeded laziness."
    ,"seq :: a -> b -> b"]

insertSeq = concatMap f
    where
        f x | "module Prelude" `isPrefixOf` x = x : seqDocs
            | otherwise = [x]


splitGHC :: [String] -> ([String],[String])
splitGHC = f True . insertSeq
    where
        f pile xs | null b = add pile xs ([], [])
                  | otherwise = add pile2 (a++[b1]) $ f pile2 bs
            where
                pile2 = if not $ "module " `isPrefixOf` b1 then pile
                        else not $ "module GHC." `isPrefixOf` b1
                b1:bs = b
                (a,b) = span isComment xs

        add left xs (a,b) = if left then (xs++a,b) else (a,xs++b)
        isComment x = x == "--" || "-- " `isPrefixOf` x


ghcPrefix :: [String]
ghcPrefix =
    ["-- Hoogle documentation, generated by Hoogle"
    ,"-- The GHC.* modules of the base library"
    ,"-- See Hoogle, http://www.haskell.org/hoogle/"
    ,""
    ,"-- | GHC modules that are part of the base library"
    ] ++ basePrefix ++ [""]

basePrefix :: [String]
basePrefix =
    ["@package base"
    ,"@version 4.2.0.0"
    ,"@haddock http://haskell.org/ghc/docs/6.12.1/html/libraries/base-4.2.0.0/"
    ,"@hackage http://haskell.org/ghc/docs/6.12.1/html/libraries/"
    ]

-}
