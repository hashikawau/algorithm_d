import System.Environment
import System.Directory
import System.IO
import Data.List
import Control.Exception

main = do
    (command:argList) <- getArgs
    dispatch command argList

dispatch :: String -> [String] -> IO ()
dispatch "add" = add
dispatch "bump" = bump
dispatch "view" = view
dispatch "remove" = remove
dispatch command = doesntExist command

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

bump :: [String] -> IO ()
bump [fileName, numberString] = do
    todoTasks <- fmap lines $ readFile fileName
    let number = read numberString
        targetTask = todoTasks !! number
        newTodoTasks = targetTask : (delete targetTask todoTasks)
    overwrite fileName newTodoTasks

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStrLn "These are your TO-DO items:"
    mapM_ putStrLn numberedTasks
    let number = read numberString
        newTodoTasks = delete (todoTasks !! number) todoTasks
    overwrite fileName newTodoTasks
    --     newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
    -- bracketOnError (openTempFile "." "temp")
    --     (\(tempName, tempHandle) -> do
    --         hClose tempHandle
    --         removeFile tempName)
    --     (\(tempName, tempHandle) -> do
    --         hPutStr tempHandle newTodoItems
    --         hClose tempHandle
    --         removeFile fileName
    --         renameFile tempName fileName)

overwrite :: String -> [String] -> IO ()
overwrite fileName todoTasks = do
    bracketOnError (openTempFile "." "temp")
        (\(tempName, tempHandle) -> do
            hClose tempHandle
            removeFile tempName)
        (\(tempName, tempHandle) -> do
            hPutStr tempHandle (unlines todoTasks)
            hClose tempHandle
            removeFile fileName
            renameFile tempName fileName)

doesntExist :: String -> [String] -> IO ()
doesntExist command _ = putStrLn $ "The " ++ command ++ " command doesn't exist"

appendtodo :: IO ()
appendtodo = do
    todoItem <- getLine
    appendFile "todo.txt" (todoItem ++ "\n")

deletetodo :: IO ()
deletetodo = do
    contents <- readFile "todo.txt"
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStrLn "These are your TO-DO items:"
    mapM_ putStrLn numberedTasks
    putStrLn "Which one do you want to delete?"
    numberString <- getLine
    let number = read numberString
        newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
    -- bracketOnError (openTempFile "." "temp")
    --     (\(tempName, tempHandle) -> do
    --         hClose tempHandle
    --         removeFile tempName)
    --     (\(tempName, tempHandle) -> do
    --         hPutStr tempHandle newTodoItems
    --         hClose tempHandle
    --         removeFile "todo.txt"
    --         renameFile tempName "todo.txt")
    (tempName, tempHandle) <- openTempFile "." "temp"
    hPutStr tempHandle newTodoItems
    hClose tempHandle
    removeFile "todo.txt"
    renameFile tempName "todo.txt"

