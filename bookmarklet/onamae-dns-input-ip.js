/**
 * お名前.comのDNS管理画面でIPアドレスを1セクションずつ入れるのがめんどくさいから
 * プロンプトにIPアドレスを入れると分割して入力してくれる奴
 * （※ブックマークレット）
 */
javascript:var ip = prompt("Input IP address\n", "0.0.0.0");
var ips = ip.split(".");
document.getElementById("txt_inputid_firt").value = ips[0];
document.getElementById("txt_inputid_second").value = ips[1];
document.getElementById("txt_inputid_third").value = ips[2];
document.getElementById("txt_inputid_last").value = ips[3];
