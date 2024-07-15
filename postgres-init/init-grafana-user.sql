DO
$$
BEGIN
    IF NOT EXISTS (
        SELECT
        FROM pg_catalog.pg_roles
        WHERE rolname = 'grafana') THEN

        -- Create Grafana user
        CREATE USER grafana WITH PASSWORD 'grafana_password';

        -- Grant read-only access to all tables in the database 'cvat'
        GRANT CONNECT ON DATABASE cvat TO grafana;
        GRANT USAGE ON SCHEMA public TO grafana;
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO grafana;

        -- Ensure future tables will also have the same permissions
        ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO grafana;

    END IF;
END
$$;
