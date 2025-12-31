create procedute `sp_tampil_katalog_buku`(
  in p_keyword varchar(50)
)
begin
  select
    buku.id_buku,
    buku.judul_buku,
    buku.pengarang,
    buku.stok_tersedia

    group concat(genre.nama_genre separator ', ') as kategori_genre
from buku
left join relasi_buku_genre on buku.id_buku = relasi_buku_genre.id_buku
left join genre on relasi_buku_genre.id_genre = genre.id_genre

where buku.judul_buku like concat('%', p_keyword, '%')
group by buku.id_buku;
end
