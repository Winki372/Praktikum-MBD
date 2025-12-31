create procedure `sp_tambah_buku`(
  in p_id_buku varchar(100),
  in p_judul_buku varchar(100),
  in p_pengarang varchar(100),
  in p_penerbit varchar(100),
  in p_tahun year,
  in p_stok_awal int,
  in p_id_genre_utama int,
  in p_admin varchar(100),
)
begin
insert into buku(id_buku, judul_buku, pengarang, penerbit, tahun_terbit, stok_total, stok_tersedia)
values(p_id_buku, p_judul_buku, p_pengarang, p_penerbit, p_tahun, p_stok_awal, p_stok_awal);

insert into relasi_buku_genre (id_buku, id_genre)
values(p_id_buku, p_id_genre_utama);

insert into log_aktivitas(aksi, keterangan, user_pelaku)
values('TAMBAH BUKU', p_judul, p_admin);

select 'Buku Berhasil Disimpan' as status;
end
