// batch = "C:\\Users\\jnkadmin\\AppData\\Local\\Temp\\yoni_temp.bat"
batch = "/tmp/tmp.sh"
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

writer.println("ls -la /home/jenkins/.ssh/")
writer.close()

command = new String[3]
command[0] = "bash"
command[1] = "-c"
command[2] = batch

/*
command[0] = "cmd"
command[1] = "/C"
command[2] = "call " + batch
*/
//    .directory(new File("C:\\Users\\jnkadmin\\AppData\\Local\\Temp\\"))
def process = new ProcessBuilder(command)
    .directory(new File("/tmp"))
    .redirectErrorStream(true)
    .start()
process.text.eachLine {println it}
process.waitFor()


