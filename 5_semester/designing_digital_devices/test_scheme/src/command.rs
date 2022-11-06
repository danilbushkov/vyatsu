use std::process::Command;


pub fn run_simulation(project_path: &str, project_name: &str) {

    let output = Command::new("quartus_sim")
            .arg(project_path.to_string()+project_name)
            .arg("--read_settings_files=on")
            .arg("--write_settings_files=off")
            .arg("-c")
            .arg(project_name)
            .output()
            .expect("failed simulation");

            //println!("{}",output.stdout.escape_ascii().to_string());
}