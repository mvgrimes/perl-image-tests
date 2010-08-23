#!/usr/bin/env perl

use strictures;
use Image::Magick;

do {
    my $img = Image::Magick->new
      or die "couldn't init Image::Magick\n";

    my $err = $img->Read('test.jpg');
    die "error reading: $err" if $err;

    my ( $w, $h ) = $img->Get( 'width', 'height' );

    $err = $img->Resize( width => $w * .25, height => $h * .25 );
    die "error resizing: $err" if $err;

    # sleep 20;
    $err = $img->Write(filename=>'test-im.jpg', compression=>'LZW', quality=> 80);
    die "error writing: $err" if $err;

};

# sleep 20;
