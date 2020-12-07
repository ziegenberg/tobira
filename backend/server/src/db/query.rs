use anyhow::Result;
use futures::stream::TryStreamExt;

use super::Db;


/// Returns meta information about all tables in the `public` schema.
pub(super) async fn all_table_names(db: &Db) -> Result<Vec<String>> {
    let rows = db.query_raw(
            "select table_name from information_schema.tables where table_schema='public'",
            std::iter::empty(),
        )
        .await?
        .map_ok(|row| row.get::<_, String>(0));

    Ok(rows.try_collect().await?)
}

/// Checks if a table with the name `table_name` exists in the public schema.
pub(super) async fn does_table_exist(db: &Db, table_name: &str) -> Result<bool> {
    let row = db.query_one(
        "select exists(
            select * from information_schema.tables
                where table_schema='public' and table_name=$1
        )",
        &[&table_name],
    ).await?;

    Ok(row.get::<_, bool>(0))
}
