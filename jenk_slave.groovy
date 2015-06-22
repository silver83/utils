batch = "C:\\Users\\jnkadmin\\AppData\\Local\\Temp\\yoni_temp.bat"
f = new File(batch)
writer = new PrintWriter(f)

/*
writer.println("git config --global core.packedGitLimit 128m")
writer.println("git config --global core.packedGitWindowSize 128m")
writer.println("git config --global pack.deltaCacheSize 128m")
writer.println("git config --global pack.packSizeLimit 128m")
writer.println("git config --global pack.windowMemory 128m")

*/

/*
rollback
writer.println("git config --global --unset core.packedGitLimit ")
writer.println("git config --global --unset core.packedGitWindowSize")
writer.println("git config --global --unset pack.deltaCacheSize ")
writer.println("git config --global --unset pack.packSizeLimit ")
writer.println("git config --global --unset pack.windowMemory ")
 */

writer.println("wmic os get freephysicalmemory")
writer.close()

command = new String[3]
command[0] = "cmd"
command[1] = "/C"
command[2] = "call " + batch

def process = new ProcessBuilder(command)
    .directory(new File("C:\\Users\\jnkadmin\\AppData\\Local\\Temp\\"))
    .redirectErrorStream(true)
    .start()
process.text.eachLine {println it}
process.waitFor()
