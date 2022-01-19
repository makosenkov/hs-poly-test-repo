{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_fp_polytech (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,0,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\makos\\VSCodeProjects\\func_prog\\hs-poly-test-repo\\.stack-work\\install\\196f7754\\bin"
libdir     = "C:\\Users\\makos\\VSCodeProjects\\func_prog\\hs-poly-test-repo\\.stack-work\\install\\196f7754\\lib\\x86_64-windows-ghc-8.10.4\\fp-polytech-0.0.0.1-BW6lDLLFBPD26eeU7kmxCo-sample-tests"
dynlibdir  = "C:\\Users\\makos\\VSCodeProjects\\func_prog\\hs-poly-test-repo\\.stack-work\\install\\196f7754\\lib\\x86_64-windows-ghc-8.10.4"
datadir    = "C:\\Users\\makos\\VSCodeProjects\\func_prog\\hs-poly-test-repo\\.stack-work\\install\\196f7754\\share\\x86_64-windows-ghc-8.10.4\\fp-polytech-0.0.0.1"
libexecdir = "C:\\Users\\makos\\VSCodeProjects\\func_prog\\hs-poly-test-repo\\.stack-work\\install\\196f7754\\libexec\\x86_64-windows-ghc-8.10.4\\fp-polytech-0.0.0.1"
sysconfdir = "C:\\Users\\makos\\VSCodeProjects\\func_prog\\hs-poly-test-repo\\.stack-work\\install\\196f7754\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "fp_polytech_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "fp_polytech_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "fp_polytech_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "fp_polytech_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "fp_polytech_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "fp_polytech_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
