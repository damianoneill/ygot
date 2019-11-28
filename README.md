# ygot

A YANG-centric Go toolkit - Go/Protobuf Code Generation; Validation; Marshaling/Unmarshaling

ygot (YANG Go Tools) is a collection of Go utilities that can be used to:

- Generate a set of Go structures and enumerated values for a set of YANG modules, with associated helper methods.
- Validate the contents of the Go structures against the YANG schema (e.g., validating range and regular expression constraints).
- Render the Go structures to an output format - such as JSON, or a set of gNMI Notifications for use in a deployment of streaming telemetry.

This image is an unofficial build of the ygot project hosted at [https://github.com/openconfig/ygot](https://github.com/openconfig/ygot).

## Downloading the image

Get the latest image

```console
docker pull damianoneill/ygot:latest
```

Or a specific version

```console
docker pull damianoneill/ygot:0.6.0
```

## Using the image

The image will setup ygot and create the generator binary. The generator binary takes a set of YANG modules as input and outputs generated code. For example:

```console
docker run -it -v $(pwd):/data damianoneill/ygot:latest generator -output_file=<outputpath> -package_name=<pkg> [yangfiles]
```

You current directory will be mounted inside the container at /data. Any files in your current directory will be available for input, writing to /data in the container will get persisted to your current directory when the container exits.
