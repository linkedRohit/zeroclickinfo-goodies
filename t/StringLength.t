#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;

zci answer_type => 'string_length';
zci is_cached   => 1;

# Build a structured answer that should match the response from the
# Perl file.
sub build_structured_answer {
    my ($string, $ans) = @_;

    return "Length of $string is $ans",
        structured_answer => {
            data => {
                title    => "$ans",
                subtitle => "$string is $ans characters long",
                # image => 'http://website.com/image.png',
            },

            templates => {
                group => 'text',
                # options => {
                #
                # }
            }
        };
}

# Use this to build expected results for your tests.
sub build_test { test_zci(build_structured_answer(@_)) }

ddg_goodie_test(
    [qw( DDG::Goodie::StringLength )],
    # At a minimum, be sure to include tests for all:
    # - primary_example_queries
    # - secondary_example_queries
    'length of qwerty' => build_test('qwerty', 6),
    'string length asdjalsdas' => build_test('asdjalsdas', 10),
    # Try to include some examples of queries on which it might
    # appear that your answer will trigger, but does not.
    #'bad example query' => undef,
);

done_testing;
