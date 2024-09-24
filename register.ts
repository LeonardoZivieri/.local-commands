import { Glob } from "bun";
import { resolve } from "path";

const scriptsFolder = resolve(__dirname, 'scripts');

const commandsAdded = [] as string[]

{
  const glob = new Glob("*.sh");
  for (const file of glob.scanSync(scriptsFolder)) {
    const command = file.replace('.sh', '');
    console.log(`chmod +x ${scriptsFolder}/${file}`)
    console.log(`alias ${command}="${scriptsFolder}/${file}"`)
    commandsAdded.push(command)
  }
}

{
  const glob = new Glob("*.js");
  for (const file of glob.scanSync(scriptsFolder)) {
    const command = file.replace('.js', '');
    console.log(`alias ${command}="bun ${scriptsFolder}/${file}"`)
    commandsAdded.push(command)
  }
}

{
  const glob = new Glob("*.ts");
  for (const file of glob.scanSync(scriptsFolder)) {
    const command = file.replace('.ts', '');
    console.log(`alias ${command}="bun ${scriptsFolder}/${file}"`)
    commandsAdded.push(command)
  }
}

console.log(`export COMMON_COMMANDS_PATH=${scriptsFolder}`)

console.log(`echo "Added ${commandsAdded.length} custom commands! See all commands in ${scriptsFolder}"`)