#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let res = reqwest::get("http://www.catb.org/jargon/html/introduction.html").await?;
    let body = res.text().await?;
    println!("{body}");
    Ok(())
}
