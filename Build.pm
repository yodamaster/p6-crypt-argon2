use v6;
use LibraryMake;

class Build {
    method build($dist) {
        my $ext = "$dist/ext/argon2-20160406";
        my $res = "$dist/resources";

        my %vars = get-vars($ext);

        mkdir($res);
        chdir($ext);
        my $proc = shell(%vars<MAKE>);

        if $proc.exitcode != 0 {
            die("make failure: "~$proc.exitcode);
        }

        my $so = %vars<SO>;
        move("$ext/libargon2$so", "$res/libargon2$so");
    }

    method isa($what) {
        return True if $what.^name eq 'Panda::Builder';
        callsame;
    }
}