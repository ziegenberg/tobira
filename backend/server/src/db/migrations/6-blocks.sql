-- This table stores content blocks of realms.
--
-- Unfortunately, having different kinds of content blocks doesn't map
-- particularly well to a relational database. Since we don't expect to have a
-- lot of different kinds, we decided to represent all in a single table where
-- columns that are unused by one type of content block are simply `null`.

select prepare_randomized_ids('block');

create type block_type as enum ('text', 'videolist');
create type video_list_layout as enum ('horizontal', 'vertical', 'grid');
create type video_list_order as enum ('new_to_old', 'old_to_new');

create table blocks (
    -- Shared properties
    id bigint primary key default randomized_id('block'),
    realm_id bigint not null references realms on delete restrict,
    type block_type not null,
    index smallint not null,
    title text,

    -- Text blocks
    text_content text,

    -- Video list blocks
    videolist_series bigint references series on delete restrict,
    videolist_layout video_list_layout,
    videolist_order video_list_order
);
