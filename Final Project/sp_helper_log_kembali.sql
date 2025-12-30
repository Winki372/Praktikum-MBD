create procedre `sp_helper_log_kembali`(
  in p_id_anggota int,
  in p_id_buku varchar(10)
)
begin
  insert into log_aktvitas(aksi, keterangan, user_pelaku, waktu_log)
  values('PENGEMBALIAN', concat('Member ', p_id_anggota, ' mengembalikan buku ', p_id_buku), 'SYSTEM', now());
end
