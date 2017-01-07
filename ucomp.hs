import Data.List
import System.Environment
import System.IO
import System.Process
import UModuleLoader
import ULambdaExpression
import UCompile
import qualified Data.Set as Set

main = do
	args <- getArgs
	if null args then
		putStrLn "ucomp: ifname.u"
	else do
		let ifname = head args
		let outputc = "-c" `elem` (tail args)
		if not$isSuffixOf ".u" ifname then do
			putStrLn "filename must end with .u"
		else do
			let basename = take (length ifname - 2) ifname
			loadc <- loadMainModule ifname defaultLoadContext
			case loadc of
				MFail msg modname pos -> putStrLn ("error loading "++modname++" at "++(show pos)++": "++msg)
				MSucc (MLoadContext loaded curchain)
					| (not (Set.member "main.main" loaded)) -> putStrLn "main.main not defined"
					| outputc -> do
						fout <- openFile (basename++".c") WriteMode
						hPutStrLn fout$compileToC$assembleChainLExpr curchain (LRef "main.main")
						hClose fout
					| otherwise -> do
						let llname = (basename ++ ".ll")
						let sname = (basename ++ ".s")
						fout <- openFile llname WriteMode
						hPutStrLn fout$compileToLLVM$assembleChainLExpr curchain (LRef "main.main")
						hClose fout
						rawSystem "llc" [llname,"-o",sname,"-O2"]
						rawSystem "clang" ["simpleruntime.ll",sname,"-o",basename,"-O2","-lm"]
						return ()
