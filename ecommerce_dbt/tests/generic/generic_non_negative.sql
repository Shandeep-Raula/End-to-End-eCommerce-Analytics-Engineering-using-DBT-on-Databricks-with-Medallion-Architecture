{ % test generic_non_negative(model, column) % }

    select *
    from {{ model }}
    where {{ column }} < 0

{ % endtest % }