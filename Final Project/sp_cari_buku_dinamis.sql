create procedure `sp_cari_buku_dinamis`(
in p_judul varchar(100),
in p_pengarang varchar(100),
in p_penerbit varchar(100),
in p_tahun varchar(4)
)
begin
select
buku.id_buku, buku.judul_buku, buku.pengarang, buku.penerbit, buku.tahun_terbit, buku.stok_tersedia, 
ifnull(GROUP_CONCAT(genre.nama_genre separator ', '), '-') as kategori
from 
buku
left join relasi_buku_genre on buku.id_buku = relasi_buku_genre.id_buku
left join genre on relasi_buku_genre = genre.id_genre
where
(p_judul is null or buku.judul_buku like concat('%', p_judul, '%'))
and
(p_pengarang is null or buku.pengarang like concat('%', p_pengarang, '%'))
and
(p_penerbit is null or buku.penerbit like concat('%', p_penerbit, '%'))
and
(p_tahun is null or buku.tahun_terbit = p_tahun)
group by
buku.id_buku;
end
