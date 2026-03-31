use std::{env, error::Error};

fn main() -> Result<(), Box<dyn Error>> {
    // Emit the instructions to the cargo build script (currently, just the current git sha hash)
    println!("cargo:rerun-if-changed=build.rs");

    let commit_hash = env::var("COMMIT_HASH")
        .unwrap_or_else(|_| "0000000000000000000000000000000000000000".to_owned());

    println!("cargo:rustc-env=VERGEN_IS_LITERALLY_TRASH__IT_DOES_NOT_WORK_AND_IT_ACTUALLY_BREAKS_EVERY_TIME_I_UPDATE_IT__LIKE_SERIOUSLY_HOW_IS_THAT_POSSIBLE___STOP_CHANGING_THE_DAMN_IMPLEMENTATION___I_JUST_WANT_A_STUPID_GIT_HASH={}", commit_hash);

    Ok(())
}
